import models
import utils.time
from app import create_app, db
from executions import run
from executions.entities.action import Action
from executions.entities.execution import Execution
from executions.entities.location import Location
from executions.entities.patient import Patient
from executions.entities.player import Player
from executions.entities.resource import Resource
from executions.entities.role import Role
from executions.entities.scenario import Scenario


def __load_resources(location_id: int) -> list[Resource]:
    """ Creates a list of resources located at the given location. """
    rs = db.session.query(models.Resource).filter(models.Resource.location_id == location_id).all()

    resources = []
    for r in rs:
        resources.append(Resource(id=r.id, name=r.name, quantity=r.quantity, picture_ref=r.picture_ref))

    return resources


def load_location(location_id: int) -> Location | None:
    """
    Loads the location with the given ID from the database along with all referenced resources and nested locations.

    Returns Location object or None (in case of an error).
    """
    with create_app().app_context():
        loc: models.Location = db.session.query(models.Location).filter(models.Location.id == location_id).first()
        if not loc:
            return None

        resources = __load_resources(loc.id)

        children_locs = db.session.query(models.Location).filter(models.Location.location_id == loc.id).all()
        sub_locs = set()
        for child in children_locs:
            sub_locs.add(load_location(child.id))

        return Location(id=loc.id, name=loc.name, picture_ref=loc.picture_ref, resources=resources, locations=sub_locs)


def __load_patients(scenario_id: int) -> dict[int, Patient]:
    """ Loads all patients associated with the given scenario from the database and returns them in a dictionary. """
    patient_ids = [participation.patient_id for participation in
                   db.session.query(models.TakesPartIn).filter(models.TakesPartIn.scenario_id == scenario_id).all()]
    ps = db.session.query(models.Patient).filter(models.Patient.id.in_(patient_ids)).all()
    patients = dict()
    for p in ps:
        p_loc = p.location
        if p_loc is None:
            p_loc = Location(id=hash(p), name=f"Patient with ID {p.id}", picture_ref=None, resources=[])
        else:
            p_loc = load_location(p.location)

        patients[p.id] = Patient(id=p.id, name=p.name, injuries=p.injuries, activity_diagram=p.activity_diagram,
                                 location=p_loc, performed_actions=[])

    return patients


def __load_actions() -> dict[int, Action] | None:
    """ Loads all actions from the database and returns them in a dictionary or None (in case of an error). """

    def __get_needed_resource_names(action_id: int) -> list[str]:
        """ Returns a list of the names of all resources needed for the given action. """
        resource_ids = [r.id for r in
                        db.session.query(models.ResourcesNeeded).filter(
                            models.ResourcesNeeded.action_id == action_id)]
        resources = db.session.query(models.Resource).filter(models.Resource.id in resource_ids).all()
        return [r.name for r in resources]

    acs = db.session.query(models.Action).all()
    if not acs:
        return None

    actions = dict()
    for ac in acs:
        resources_needed = __get_needed_resource_names(ac.id)
        actions[ac.id] = Action(id=ac.id, name=ac.name, result=ac.results, picture_ref=ac.picture_ref,
                                duration_sec=ac.duration_secs, resources_needed=resources_needed)

    return actions


def __load_scenario(scenario_id: int) -> Scenario | None:
    """ Loads the scenario with the given id from the database and returns it or None (in case of an error). """
    # Load scenario data
    scenario = db.session.query(models.Scenario).filter(models.Scenario.id == scenario_id).first()
    if not scenario:
        return None

    # Load all actions
    actions = __load_actions()
    if not actions:
        return None

    # Load all patients in this scenario
    patients = __load_patients(scenario_id)
    if not patients:
        return None

    # Locations are loaded on-demand as there is no mapping between scenario/execution and locations. Only exception are
    # those locations created for patients during object initialization.
    locations = {}
    for patient in patients.values():
        patient_location = patient.location
        locations[patient_location.id] = patient_location

    return Scenario(id=scenario.id, name=scenario.name, patients=patients, actions=actions, locations=locations)


def __load_role(role_id: int) -> Role | None:
    """ Loads and returns the a Role object for a given role ID. """
    role = db.session.query(models.Role).filter(models.Role.id == role_id).first()
    if not role:
        return None

    return Role(role.id, role.name, role.short_name, role.power)


def __load_players(exec_id: id) -> dict[str, Player] | None:
    """ Loads all players of the given Execution from the database and returns them in a dictionary or None."""
    ps: list[models.Player] = db.session.query(models.Player).filter(models.Player.execution_id == exec_id).all()
    if not ps:
        return None

    players = dict()
    for p in ps:
        player_role = __load_role(p.role_id)
        player_loc = load_location(p.location_id)
        players[p.tan] = Player(tan=p.tan, name=None, location=player_loc, accessible_locations=set(),
                                alerted=p.alerted, activation_delay_sec=p.activation_delay_sec, role=player_role)

    return players


def load_execution(exec_id: int) -> bool:
    """
    Loads an Execution (Simulation) and all associated data into memory and activates it to make it ready for execution.

    Returns True for success, False otherwise.
    """
    with create_app().app_context():
        ex: models.Execution = db.session.query(models.Execution).filter(models.Execution.id == exec_id).first()
        # If query yields no result, report failure
        if not ex:
            return False

        players = __load_players(ex.id)
        # If players could not be loaded, report failure
        if not players:
            return False

        scenario = __load_scenario(ex.scenario_id)
        # If scenario data could not be loaded, report failure
        if not scenario:
            return False

        # Add player locations to scenario locations
        for player in players.values():
            if player.location not in scenario.locations and player.location is not None:
                l_id = player.location.id
                scenario.locations[l_id] = player.location

        execution = Execution(id=ex.id, scenario=scenario, starting_time=-1, players=players,
                              status=Execution.Status.PENDING)
        # Activate execution (makes it accessible by API)
        run.activate_execution(execution)
        return True
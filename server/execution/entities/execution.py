import json
from enum import Enum

from executions.entities.player import Player
from executions.entities.scenario import Scenario


class Execution:

    class Status(Enum):
        RUNNING = "running"
        PENDING = "pending"
        FINISHED = "finished"
        UNKNOWN = "unknown"

    def __init__(self, id: int, scenario: Scenario, players: dict[str, Player], status: Status,
                 starting_time: int | None = None):
        self.id = id
        self.scenario = scenario
        self.players = players
        self.status = status
        self.starting_time = starting_time

    def to_dict(self, shallow: bool = False):
        """
        Returns all fields of this class in a dictionary. By default, all nested objects are included. In case the
        'shallow'-flag is set, only the object reference in form of a unique identifier is included.
        """
        return {
            'id': self.id,
            'scenario': self.scenario.id if shallow else self.scenario.to_dict(),
            'starting_time': self.starting_time,
            'players': [player.tan if shallow else player.to_dict() for player in list(self.players.values())],
            'status': self.status.name
        }

    def to_json(self, shallow: bool = False):
        """
        Returns this object as a JSON. By default, all nested objects are included. In case the 'shallow'-flag is set,
        only the object reference in form of a unique identifier is included.
        """
        return json.dumps(self.to_dict(shallow))
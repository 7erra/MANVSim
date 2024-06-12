import time

from flask_jwt_extended import get_jwt

from executions import run


def __get_param_from_jwt(param):
    claims = get_jwt()
    return claims[param]


def get_execution_and_player():
    """ Returns the current execution instance as well as the player referenced by TAN"""
    exec_id = __get_param_from_jwt("exec_id")
    tan = __get_param_from_jwt("sub")
    execution = run.exec_dict[exec_id]
    player = execution.players[tan]

    return run.exec_dict[exec_id], player


def get_current_secs():
    return time.time()

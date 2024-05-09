""" Reader of secrets from .env file. """
import os
import typing

from dotenv import find_dotenv, load_dotenv
from robot.api.deco import keyword

load_dotenv(find_dotenv())


@keyword
def get_value(env_var_name: str) -> typing.Any:
    """ Get environment variable from .env file by variable name.

    Args:
        env_var_name: name of a variable.
    """
    return os.getenv(env_var_name)

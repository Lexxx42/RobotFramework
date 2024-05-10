*** Settings ***
Documentation    This is resource file for extracting secrets from .env file.
Library    secret_reader.py

*** Variables ***

*** Keywords ***
Get correct name
    ${CORRECT_NAME}    get_env_value    env_var_name=USER_NAME

    RETURN    ${CORRECT_NAME}

Get correct pass
    ${CORRECT_PASS}    get_env_value    env_var_name=PASSWORD

    RETURN    ${CORRECT_PASS}

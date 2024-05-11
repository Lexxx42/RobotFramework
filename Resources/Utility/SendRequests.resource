*** Settings ***
Documentation    Sending requests and checking results.
Library    ../TestHelper/BasicHelper.py

*** Variables ***

*** Keywords ***
Send request to reqres
    [Arguments]    ${method_name}    &{kwargs}

    send_request    reqres_method=${method_name}    &{kwargs}

Check response status code
    [Arguments]    ${exp_code}

    check_status_code    exp_code=${exp_code}

Check model is valid
    [Arguments]    ${validation_model}=${None}

    check_response_model_is_valid    validation_model=${validation_model}

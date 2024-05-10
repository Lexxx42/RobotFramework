*** Settings ***
Documentation    Data Driven Testing form csv file.
Resource    ../Resources/CommonFunctionality.resource
Variables    ../Resources/Locators/demoqa_locators.py
Library    ../Resources/Utility/secret_reader.py
Library    DataDriver    ../TestData/login_data.csv

Suite Setup    CommonFunctionality.Start test case    https://demoqa.com/login
Suite Teardown    CommonFunctionality.Finish test case
Test Template    Invalid login scenarios

*** Variables ***
${correct_name}    Correct name
${correct_pass}    Correct pass

*** Test Cases ***
Verify login fails with     ${username}    ${password}    ${error_message}


*** Keywords ***
Invalid login scenarios
    [Arguments]    ${username}    ${password}    ${error_message}

    IF    $username == $correct_name
        ${username}    Get correct name

    ELSE IF    $password == $correct_pass
        ${password}    Get correct pass

    END

    Log    username: ${username}, password: ${password}    console=True

    Input Text    ${INPUT_USERNAME}    ${username}
    Input Text    ${INPUT_PASSWORD}    ${password}

    Click Button    ${BUTTON_LOGIN}

    Wait Until Element Is Visible    locator=${ERROR_MESSAGE_PAGE}    error=${error message}

Get correct name
    ${CORRECT_NAME}    get_env_value    env_var_name=USER_NAME

    RETURN    ${CORRECT_NAME}

Get correct pass
    ${CORRECT_PASS}    get_env_value    env_var_name=PASSWORD

    RETURN    ${CORRECT_PASS}

*** Settings ***
Documentation    Data Driven Testing form xlsx file.
Resource    ../Resources/CommonFunctionality.resource
Resource    ../Resources/Utility/SecretsGetter.resource
Variables    ../Resources/Locators/demoqa_locators.py
Library    DataDriver    ../TestData/login_data.xlsx    sheet_name=Sheet1

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
        ${username}    SecretsGetter.Get correct name

    ELSE IF    $password == $correct_pass
        ${password}    SecretsGetter.Get correct pass

    END

    Log    username: ${username}, password: ${password}    console=True

    Input Text    ${INPUT_USERNAME}    ${username}
    Input Text    ${INPUT_PASSWORD}    ${password}

    Click Button    ${BUTTON_LOGIN}

    Wait Until Element Is Visible    locator=${ERROR_MESSAGE_PAGE}    error=${error message}

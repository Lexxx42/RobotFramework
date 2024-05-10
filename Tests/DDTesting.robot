*** Settings ***
Documentation    Data Driven Testing.
Resource    ../Resources/CommonFunctionality.resource
Resource    ../Resources/Utility/SecretsGetter.resource
Variables    ../Resources/Locators/demoqa_locators.py

Suite Setup    CommonFunctionality.Start test case    https://demoqa.com/login
Suite Teardown    CommonFunctionality.Finish test case
Test Template    Invalid login scenarios

*** Variables ***
# CANT CALL KEYWORDS HERE, SAD
${correct_name}    Correct name
${correct_pass}    Correct pass

# CANT CALL KEYWORDS HERE TOO, VERY SAD
*** Test Cases ***                                    USERNAME            PASSWORD            ERROR MESSAGE
Verify login fails - Blank username and pass          ${EMPTY}            ${EMPTY}            OPPPS!
Verify login fails - Wrong username                   name                ${correct_pass}     OPPPS!
Verify login fails - Wrong password                   ${correct_name}     cool_pass           OPPPS!
Verify login fails - Wrong username and password      name                cool_pass           OPPPS!


*** Keywords ***
Invalid login scenarios
    [Arguments]    ${username}    ${password}    ${error message}

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

*** Settings ***
Documentation    Work with radio buttons.
Resource    ../Resources/CommonFunctionality.resource
Resource    ../Resources/PageObjects/RadioButtonsPage.resource

Test Setup    CommonFunctionality.Start test case    https://demoqa.com/radio-button
Test Teardown    CommonFunctionality.Finish test case

*** Variables ***
&{RADIO_ID_TEXT}    yesRadio=Yes    impressiveRadio=Impressive    noRadio=No


*** Test Cases ***
Click on radio and check text.
    [Documentation]    Verify radio button activation.
    [Tags]    functional

    FOR    ${elem_id}    IN    @{RADIO_ID_TEXT}
        RadioButtonsPage.Click by radio    ${elem_id}
        RadioButtonsPage.Check radio text    ${RADIO_ID_TEXT}[${elem_id}]
    END

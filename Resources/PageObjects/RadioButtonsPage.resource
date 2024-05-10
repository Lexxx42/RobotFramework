*** Settings ***
Documentation    Working with radiobuttons in RF.
Library    String
Library    SeleniumLibrary
Variables    ../Locators/demoqa_locators.py

*** Variables ***

*** Keywords ***
Click by radio
     [Arguments]    ${text}

     ${locator}    Format String    ${ELEMENT_BY_ID}    text=${text}

     Click Element    ${locator}

Check radio text
    [Arguments]    ${text}

    Element Text Should Be    ${SUCCESS_TEXT}    ${text}

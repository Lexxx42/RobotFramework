*** Settings ***
Documentation    This is resource file for common functionality.
Library    SeleniumLibrary

*** Keywords ***
Start test case
    [Arguments]    ${link}

    Open Browser    ${link}    chrome
    Maximize Browser Window
    Set log level    TRACE


Finish test case
    Close Browser

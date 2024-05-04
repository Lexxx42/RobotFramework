*** Settings ***
Documentation    This is resource file for common functionality.
Library    SeleniumLibrary

*** Variables ***
${browser}    chrome

*** Keywords ***
Start test case
    [Arguments]    ${link}

    Open Browser    ${link}    ${browser}
    Maximize Browser Window
    Set log level    TRACE


Finish test case
    Close Browser

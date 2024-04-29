*** Settings ***
Documentation    Basic search functionality on ebay.
Library    SeleniumLibrary

*** Variables ***
${TEXT}    Mobile

*** Test Cases ***
Verify basic search functionality for eBay.
    [Documentation]    This test case verifies basic search functionality.
    [Tags]    functional

    Start TestCase
    Verify Search Results
    Finish TestCase

*** Keywords ***
Start TestCase
    Open Browser    https://www.ebay.com/    chrome
    Maximize Browser Window

Verify Search Results
    Input Text    css:#gh-ac    ${TEXT}
    Press Keys    xpath://*[@id="gh-btn"]    Return
    Page Should Contain    результат. для ${TEXT}

Finish TestCase
    Close Browser

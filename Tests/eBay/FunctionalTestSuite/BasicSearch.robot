*** Settings ***
Documentation    Basic search functionality on ebay.
Library    SeleniumLibrary

*** Variables ***
${TEXT}    Mobile

*** Test Cases ***
Verify basic search functionality for eBay.
    [Documentation]    This test case verifies basic search functionality.
    [Tags]    functional

    Open Browser    https://www.ebay.com/    chrome
    Input Text    //*[@id="gh-ac"]    ${TEXT}
    Press Keys    //*[@id="gh-btn"]    Return
    Page Should Contain    результат. для ${TEXT}
    Close Browser

*** Keywords ***

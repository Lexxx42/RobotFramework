*** Settings ***
Documentation    Common functionality for the header of eBay.
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
Input text and click search
    [Arguments]    ${text}

    Input Text    css:#gh-ac    ${text}
    Press Keys    xpath://*[@id="gh-btn"]    Return

Click on advanced search link
    Click Element    xpath://*[@id="gh-as-a"]

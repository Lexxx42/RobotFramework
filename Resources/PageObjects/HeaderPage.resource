*** Settings ***
Documentation    Common functionality for the header of eBay.
Library    SeleniumLibrary
Variables    ../Locators/ebay_locators.py

*** Variables ***

*** Keywords ***
Input text and click search
    [Arguments]    ${text}

    Input Text    ${SearchField}    ${text}
    Press Keys    ${SearchButton}    Return

Click on advanced search link
    Click Element    ${AdvancedSearchLink}

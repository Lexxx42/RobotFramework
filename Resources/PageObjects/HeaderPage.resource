*** Settings ***
Documentation    Common functionality for the header of eBay.
Library    SeleniumLibrary
Variables    ../Locators/ebay_locators.py

*** Variables ***

*** Keywords ***
Input text and click search
    [Arguments]    ${text}

    Input Text    ${SEARCH_FIELD}    ${text}
    Press Keys    ${SEARCH_BUTTON}    Return

Click on advanced search link
    Click Element    ${ADVANCED_SEARCH_LINK}

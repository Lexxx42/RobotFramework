*** Settings ***
Documentation    Basic search functionality on ebay.
Resource    ../../../Resources/CommonFunctionality.resource
Resource    ../../../Resources/eBayKeywords.resource

*** Variables ***
${TEXT}    Mobile

*** Test Cases ***
Verify basic search functionality for eBay.
    [Documentation]    This test case verifies basic search functionality.
    [Tags]    functional

    Start test case    https://www.ebay.com/
    Verify search results    Mobile
    Filter results by condition
    Verify filter results
    Finish test case

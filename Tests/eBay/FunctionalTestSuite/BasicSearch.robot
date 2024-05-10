*** Settings ***
Documentation    Basic search functionality on ebay.
Resource    ../../../Resources/CommonFunctionality.resource
Resource    ../../../Resources/eBayKeywords.resource

Test Setup    CommonFunctionality.Start test case    https://www.ebay.com/
Test Teardown    CommonFunctionality.Finish test case

*** Variables ***
${TEXT}    Mobile

*** Test Cases ***
Verify basic search functionality for eBay.
    [Documentation]    This test case verifies basic search functionality.
    [Tags]    functional

    eBayKeywords.Verify search results    Mobile
    eBayKeywords.Filter results by condition
    eBayKeywords.Verify filter results

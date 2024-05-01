*** Settings ***
Documentation    Basic search functionality on ebay using POM.
Resource    ../../../Resources/CommonFunctionality.resource
Resource    ../../../Resources/PageObjects/HeaderPage.resource
Resource    ../../../Resources/PageObjects/SearchResultsPage.resource

Test Setup    CommonFunctionality.Start test case    https://www.ebay.com/
Test Teardown    CommonFunctionality.Finish test case

*** Variables ***
${TEXT}    Mobile
${CONDITION}    Новый

*** Test Cases ***
Verify basic search functionality for eBay.
    [Documentation]    This test case verifies basic search functionality using POM.
    [Tags]    functional

    HeaderPage.Input text and click search    ${TEXT}
    SearchResultsPage.Verify search results    ${TEXT}

Verify condition search functionality for eBay.
    [Documentation]    This test case verifies change of product condition search functionality using POM.
    [Tags]    functional
    
    HeaderPage.Input text and click search    ${TEXT}
    SearchResultsPage.Select product condition    ${CONDITION}
    SearchResultsPage.Verify filter results    ${CONDITION}

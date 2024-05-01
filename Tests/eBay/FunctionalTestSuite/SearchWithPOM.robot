*** Settings ***
Documentation    Basic search functionality on ebay using POM.
Resource    ../../../Resources/CommonFunctionality.resource
Resource    ../../../Resources/PageObjects/HeaderPage.resource
Resource    ../../../Resources/PageObjects/SearchResultsPage.resource

Test Setup    CommonFunctionality.Start test case    https://www.ebay.com/
Test Teardown    CommonFunctionality.Finish test case

*** Variables ***
${SEARCH_TEXT}    Mobile
@{CONDITIONS}    Новый    Любое состояние    Б/у    Не указано
&{DELIVERY_TYPES}    FREE_INTERNATIONAL=Бесплатная международная доставка


*** Test Cases ***
Verify basic search functionality for eBay.
    [Documentation]    This test case verifies basic search functionality using POM.
    [Tags]    functional

    HeaderPage.Input text and click search    ${SEARCH_TEXT}
    SearchResultsPage.Verify search results    ${SEARCH_TEXT}

Verify condition search functionality for eBay.
    [Documentation]    This test case verifies change of product condition search functionality using POM.
    [Tags]    functional
    
    HeaderPage.Input text and click search    ${SEARCH_TEXT}
    SearchResultsPage.Select product condition    ${CONDITIONS}[0]
    SearchResultsPage.Verify filter results    ${CONDITIONS}[0]

Verify delivery type search functionality for eBay.
    [Documentation]    This test case verifies change of delivery type search functionality using POM.
    [Tags]    functional

    HeaderPage.Input text and click search    ${SEARCH_TEXT}
    SearchResultsPage.Select delivery option    ${DELIVERY_TYPES.FREE_INTERNATIONAL}
    SearchResultsPage.Verify filter delivery results    ${DELIVERY_TYPES.FREE_INTERNATIONAL}

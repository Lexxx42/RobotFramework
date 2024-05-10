*** Settings ***
Documentation    Common functionality for the search results of eBay.
Library    String
Library    SeleniumLibrary
Variables    ../Variables/ebay_constants.py
Variables    ../Locators/ebay_locators.py

*** Variables ***

*** Keywords ***
Verify search results
     [Arguments]    ${text}

     Page Should Contain    результат. для ${text}

Select product condition
    [Arguments]    ${text}

    ${locator} =  Format String  ${DROPDOWN_OPTION}    text=${text}

    Press Keys    ${PRODUCT_CONDITIONS_DROPDOWN}    Return
    Press Keys    ${locator}    Return

Select delivery option
    [Arguments]    ${text}

    ${locator} =  Format String  ${DROPDOWN_OPTION}    text=${text}

    Press Keys    ${SHIPMENTS_DROPDOWN}    Return
    Press Keys    ${locator}    Return

Verify filter results
    [Arguments]    ${text}

    ${locator} =  Format String  ${FILTER_RESULT}    text=${text}

    Element Should Be Visible    ${locator}

Verify filter delivery results
    [Arguments]    ${text}

    ${locator} =  Format String  ${FILTER_RESULT}    text=${AVAILABLE_DELIVERY_FILTERS}[${text}]

    Element Should Be Visible    ${locator}

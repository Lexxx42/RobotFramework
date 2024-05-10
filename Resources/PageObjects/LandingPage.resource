*** Settings ***
Documentation    Common functionality for the landing page of eBay.
Library    String
Library    SeleniumLibrary
Variables    ../Locators/ebay_locators.py

*** Variables ***

*** Keywords ***
Select shopping category
     [Arguments]    ${text}

     ${locator}    Format String    SHOPPING_CATEGORY_BUTTON    text=${text}

     Click Element    ${locator}

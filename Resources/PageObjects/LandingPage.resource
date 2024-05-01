*** Settings ***
Documentation    Common functionality for the landing page of eBay.
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
Select shopping category
     [Arguments]    ${text}

     Click Element    xpath://li/a[text()="${text}"]

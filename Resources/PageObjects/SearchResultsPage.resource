*** Settings ***
Documentation    Common functionality for the search results of eBay.
Library    SeleniumLibrary
Variables    ../Variables/ebay_constants.py

*** Variables ***

*** Keywords ***
Verify search results
     [Arguments]    ${text}

     Page Should Contain    результат. для ${text}

Select product condition
    [Arguments]    ${text}

    Press Keys    xpath://span[text()="Состояние товара"]/ancestor::button    Return
    Press Keys    xpath://a/span[text()="${text}"]    Return

Select delivery option
    [Arguments]    ${text}

    Press Keys    xpath://span[text()="Доставка"]/ancestor::button    Return
    Press Keys    xpath://a/span[text()="${text}"]    Return

Verify filter results
    [Arguments]    ${text}

    Element Should Be Visible    xpath://ul[@class="carousel__list"]//div[text()="${text}"]

Verify filter delivery results
    [Arguments]    ${text}

    Element Should Be Visible    
    ...    xpath://ul[@class="carousel__list"]//div[text()="${AVAILABLE_DELIVERY_FILTERS}[${text}]"]

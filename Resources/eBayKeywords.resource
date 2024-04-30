*** Settings ***
Documentation    Resources for eBay tests.
Library    SeleniumLibrary

*** Keywords ***
Verify search results
    [Arguments]    ${text}

    Input Text    css:#gh-ac    ${text}
    Press Keys    xpath://*[@id="gh-btn"]    Return
    Page Should Contain    результат. для ${text}

Filter results by condition
    Press Keys    xpath://span[text()="Состояние товара"]/ancestor::button    Return
    Press Keys    xpath://a/span[text()="Новый"]    Return

Verify filter results
    Element Should Be Visible    xpath://ul[@class="carousel__list"]//div[text()="Новый"]

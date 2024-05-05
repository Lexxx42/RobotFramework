*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}    http://google.com
${browser}    chrome

*** Test Cases ***
TC to demonstrate Browser Operation keywords
    [Documentation]    TC to demonstrate Browser Operation keywords in RF

    Open Browser    ${url}    ${browser}    alias=ChromeRCV
    Maximize Browser Window

    Open Browser    url=about:blank    browser=ff    alias=RCVFF

    &{alias}    Get Browser Aliases

    Log    message=Browser aliases: ${alias}    level=DEBUG    console=True

    @{browser ids}    Get Browser Ids

    Log    message=Browser ids: ${browser ids}    level=DEBUG    console=True

    Switch Browser    1

    Go To    https://demoqa.com/

    Close All Browsers

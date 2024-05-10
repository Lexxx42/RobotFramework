*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
TC to demonstrate Browser Windows Operation keywords
    [Documentation]    TC to demonstrate Browser Windows Operation keywords in RF
    ...    Sleeps only used for human to understand whats happening

    Open Browser   https://demoqa.com/browser-windows    chrome
    Maximize Browser Window

    Wait Until Element Is Visible    xpath://h1[text()="Browser Windows"]
    Click Element    id:windowButton
    Sleep    2
    
    @{WindowHandles}    Get Window Handles
    Log    message=Window Handles: ${WindowHandles}    level=DEBUG    console=True

    @{WindowIdentifiers}    Get Window Identifiers
    Log    message=Window Identifiers: ${WindowIdentifiers}    level=DEBUG    console=True

    @{WindowNames}    Get Window Names
    Log    message=Window Names: ${WindowNames}    level=DEBUG    console=True

    @{WindowTitles}    Get Window Titles
    Log    message=Window Titles: ${WindowTitles}    level=DEBUG    console=True

    @{WindowPosition}    Get Window Position
    Log    message=Window Position before edit: ${WindowPosition}    level=DEBUG    console=True

    Set Window Position    100    200

    ${x}    ${y}    Get Window Position
    Log    message=Window Position after edit: x\=${x} y\=${y}    level=DEBUG    console=True
    Sleep    2

    Set Window Size    800    600
    ${width}    ${height}    Get Window Size
    Log    message=Window Size after edit: width\=${width} height\=${height}    level=DEBUG    console=True

    Switch Window    ${WindowHandles}[1]
    Log    message=Switched to window: ${WindowHandles}[1]    level=DEBUG    console=True
    Sleep    2

    Close Window

    Switch Window    ${WindowHandles}[0]
    Sleep    2
    Close Window

    Close Browser

*** Settings ***
# docs
# libs
# resources
# setups and teardowns
Library    SeleniumLibrary

*** Variables ***


*** Test Cases ***
# docs for TC
# actual scripts
Google test
    [Documentation]    Open browser and close it.
    [Tags]    regression

    Open Browser    https://www.google.com/    chrome
    Close Browser

*** Keywords ***
# optional. most of the time moved to separate file

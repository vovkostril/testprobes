*** Settings ***
Documentation       New test by web
Library             SeleniumLibrary
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        https://stackoverflow.com/
${BROWSER}          Chrome

*** Keywords ***
Open Browser To
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Title Should Be    Stack Overflow


*** Test Cases ***
Open and click
    [Documentation]    Try to use locators
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Sleep    10
    # Wait Until Page Contains Element    //*[@id="hostName"]    timeout=30
    Wait Until Page Contains Element    css:body > header > div > nav > ol > li:nth-child(3) > a   timeout=50
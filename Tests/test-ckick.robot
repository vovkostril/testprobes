*** Settings ***
Documentation       New test by web
Library             SeleniumLibrary
Suite Teardown      Close Browser

*** Variables ***
${LOGIN URL}        http://192.168.0.3/
${PING URL}         http://192.168.0.3/ping4.htm
${BROWSER}          Chrome

*** Keywords ***
Open Browser To Login Page
    Open Browser        ${LOGIN URL}        ${BROWSER}      alias=tab1
    Title Should Be    Login

Open Browser To Ping Page
    Open Browser        ${PING URL}        ${BROWSER}       alias=tab2
    # Title Should Be    Ping

Input Username
    [Arguments]     ${username}
    Input Text    user    ${username}

Input Password
    [Arguments]     ${password}
    Input Text    pass    ${password}

Submit Credentials
    Click Button    Login

Welcome Page Should Be Open
    # Title Should Be    Dyna Wiz
    Title Should Be    Connection Master

Ping Page Should Be Open
    Title Should Be    Login

*** Test Cases ***
Open and click
    [Documentation]    Try to login and click the ping url to be opened
    Open Browser        ${LOGIN URL}        ${BROWSER}      alias=tab1
    Input Username      admin
    Submit Credentials
    Welcome Page Should Be Open
    Set Selenium Timeout    5
    # Click Link    xpath="ping4.htm"
    Click Element    name="ping4.htm"

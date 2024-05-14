*** Settings ***
Documentation       New test by web
Library             SeleniumLibrary
Suite Teardown      Close Browser

*** Variables ***
${LOGIN URL}        http://192.168.0.33/
${PING URL}         http://192.168.0.34/ping4.htm
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
Valid login
    Open Browser To Login Page
    Input Username      admin
#    Input Password
    Submit Credentials
    Welcome Page Should Be Open
    Open Browser To Ping Page
    Switch browser  tab2
    Title Should Be    Ping

Valid Ping
    Open Browser To Ping Page
    Input Username      admin
    Submit Credentials
    Input Text ${ip_addr} ${192.168.0.4}
    Click Element	name:Start


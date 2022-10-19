*** Settings ***
Documentation       pretest before no card
Library             SeleniumLibrary
Library    String
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
${URL2}        http://192.168.0.4/index.htm
${BROWSER}          Chrome
${COMPORT}          COM3
${username}     admin

*** Keywords ***
Open Browser And Login
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Title Should Be    Login
    Input Text    user    ${username}
    Click Button    Login

Open Browser And Login 2
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
    Title Should Be    Login
    Input Text    user    ${username}
    Click Button    Login

Welcome Page Should Be Open
    # Title Should Be    Dyna Wiz
    Page Should Contain    Connection Master

Open info about FPGA


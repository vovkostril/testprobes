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
${version}     2744
${fpga}     1

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

Go to HW
    Select Frame    name:main
    Current Frame Should Contain    main
    Wait Until Element Is Visible    //*[@id="hwiButton"]/input
    Click Element    //*[@id="hwiButton"]/input
    Sleep    2
    Page Should Contain    Hardware Inventory
    Unselect Frame

Refresh button
    Select Frame    name:main
    Sleep    5
    Click Button    Refresh
    Sleep    5
    Wait Until Element Is Visible    //*[@id="autorefresh"]
    Click Element    //*[@id="autorefresh"]
    Unselect Frame
    Sleep    5

Open info about FPGA
    Select Frame      name:contents
    Wait Until Element Is Visible    //*[@id="menu"]/tbody/tr[2]/td/ul/li[2]/details/ul/li[1]/details/summary
    Click Element    //*[@id="menu"]/tbody/tr[2]/td/ul/li[2]/details/ul/li[1]/details/summary
    Sleep    5
    Click Element    //*[@id="sys.htm"]
    Sleep    5

*** Test Cases ***
Test 1: Go to info and get FPGA and version ACTIVE
    [Documentation]    Test NO card state via WEB
    [Tags]  Open bro
    Open Browser And Login
    Sleep   10
    Welcome Page Should Be Open
    Sleep    5
    Page Should Contain    Active CE
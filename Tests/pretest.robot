*** Settings ***
Documentation       Pretest before no card
Library             SeleniumLibrary
Library    String
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${BROWSER}          Chrome
${COMPORT}          COM3

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
    Unselect Frame

*** Test Cases ***
Test 1: Go to info and get FPGA and version ACTIVE
    [Documentation]    Pre test before do thu cards
    [Tags]  Open and find info on Active by web
    Open Browser And Login
    Sleep   10
    Welcome Page Should Be Open
    Sleep    5
    Page Should Contain    Active CE
    Open info about FPGA
    Select Frame      name:main
    Wait Until Element Is Visible    //*[@id="sys_fpga2_vers"]
    ${test1}     Get Text    //*[@id="sys_fpga2_vers"]
    Should Contain    ${test1}    ${fpga}
    Wait Until Element Is Visible    //*[@id="sys_code_rev"]
    ${test2}     Get Text    //*[@id="sys_code_rev"]
    Should Contain    ${test2}    ${version}
    Sleep    5
    Unselect Frame

Test 2: Go to info and get FPGA and version Standby
    [Tags]  Open and find info on Standby by web
    Open Browser And Login 2
    Sleep   10
    Welcome Page Should Be Open
    Sleep    5
    Page Should Contain    Standby CE
    Open info about FPGA
    Select Frame      name:main
    Wait Until Element Is Visible    //*[@id="sys_fpga2_vers"]
    ${test1}     Get Text    //*[@id="sys_fpga2_vers"]
    Should Contain    ${test1}    ${fpga}
    Wait Until Element Is Visible    //*[@id="sys_code_rev"]
    ${test2}     Get Text    //*[@id="sys_code_rev"]
    Should Contain    ${test2}    ${version}
    Sleep    5
    Unselect Frame

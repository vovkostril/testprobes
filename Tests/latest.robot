*** Settings ***
Documentation       Check power cards
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Library        ../Libs/test_parse.py
Library             ../Libs/pre_tests.py
Library    XML
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
${URL2}        http://192.168.0.4/index.htm
${IPA}        192.168.0.3
${IPB}        192.168.0.4
${BROWSER}          Chrome
${COMPORT}          COM3
${username}     admin
${SWVer}          CM Native CE R4.4
${activepw}          7
${standbypw}          8
${version}     2744
${fpga}     1
${titleLogin}        Login

*** Keywords ***
Open Browser And Login
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Sleep    5
    ${title}        Get Title
    IF    "${title}" == "${titleLogin}"
        Input Text    user    ${username}
        Click Button    Login
    ELSE
        Get Title
        Page Should Contain    Connection Master
    END

Open Browser And Login 2
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
    Sleep    5
    ${title}        Get Title
    IF    "${title}" == "${titleLogin}"
        Input Text    user    ${username}
        Click Button    Login
    ELSE
        Get Title
        Page Should Contain    Connection Master
    END

Ping
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Click Element    //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Sleep    5
    Click Element    //*[@id="ping4.htm"]
    Sleep    5
    Page Should Contain    Ping (IPv4)
    Unselect Frame
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
    Sleep    5
    Unselect Frame

Go to main
    Sleep    10
    Select Frame    name:top
    Current Frame Should Contain    top
    Element Should Be Visible   //*[@id="logotext"]
    Element Should Be Visible   //ul/li[3]
    Element Should Be Visible   //ul/li[3]/div/a[1]
    Click Element   //ul/li[3]/div/a[1]
    Sleep    10
    Unselect Frame

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

*** Settings ***
Documentation       New test no card by web
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Library             ../Libs/test_parse.py
Library             ../Libs/pre_tests.py
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
${URL2}        http://192.168.0.4/index.htm
${BROWSER}          Chrome
${PORT}        COM3
${username}     admin
${FPGA2}        1
${REVISION}     2744
${SWVer}          CM Native CE R4.4
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

Get Slot Status 9
    Select Frame    name:main
    Element Should Be Visible   //*[@id="unitTableContentTbody"]/tr/td[1]
    ${loc}        Get Text    //*[@id="unitTableContentTbody"]/tr/td[1]
    Should Contain    ${loc}    16 Slot Subrack
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[9]/td[2]
    ${card1}        Get Text    //*[@id="slotTableContentTbody"]/tr[9]/td[2]
    Should Contain    ${card1}    Ethernet
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[9]/td[3]
    ${card2}        Get Text    //*[@id="slotTableContentTbody"]/tr[9]/td[3]
    Should Contain    ${card2}    Ethernet
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[9]/td[6]
    ${card3}        Get Text    //*[@id="slotTableContentTbody"]/tr[9]/td[6]
    Should Contain    ${card3}    Operational
    Unselect Frame

Get Slot Status 10
    Select Frame    name:main
    Element Should Be Visible   //*[@id="unitTableContentTbody"]/tr/td[1]
    ${loc}        Get Text    //*[@id="unitTableContentTbody"]/tr/td[1]
    Should Contain    ${loc}    16 Slot Subrack
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[10]/td[2]
    ${card1}        Get Text    //*[@id="slotTableContentTbody"]/tr[10]/td[2]
    Should Contain    ${card1}    Ethernet
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[10]/td[3]
    ${card2}        Get Text    //*[@id="slotTableContentTbody"]/tr[10]/td[3]
    Should Contain    ${card2}    Ethernet
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[10]/td[6]
    ${card3}        Get Text    //*[@id="slotTableContentTbody"]/tr[10]/td[6]
    Should Contain    ${card3}    Operational
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

*** Test Cases ***
Test 1: Check sh version
    [Tags]  Check version
    ${test1}      Parse    ${PORT}      ${SWVer}     ${REVISION}     ${FPGA2}
    Should Contain    ${test1}    3

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
${COMPORT}          COM3
${PORT}        COM3
${username}     admin
${FPGA2}        1
${REVISION}     2744
${SWVer}          CM Native CE R4.4

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

Ping test
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Click Element    //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Sleep    5
    Click Element    //*[@id="ping4.htm"]
    Sleep    15
    Page Should Contain    Ping (IPv4)
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
Test : Check sh version
    [Tags]  Check version
    ${test1}      Parse    ${PORT}      ${SWVer}     ${REVISION}     ${FPGA2}
    Should Contain    ${test1}    3

Test : Open and click
    Open Browser And Login
    Sleep   10
    Welcome Page Should Be Open
    Sleep    5
    Page Should Contain    Active CE

Test : Check pings between Active/Standby
    Sleep    5
    Ping test
    Sleep    5
    Go to main

Test : Go to hardware
    [Tags]  Hardware check button
    Go to HW
    Sleep    2

Test : Test the card state
    [Tags]  Slot status
    Get Slot Status 9
    Sleep    5
    Get Slot Status 10
    Sleep    5

Test : Test card no card 9
    [Tags]  Check status card
    Refresh button
    Sleep    5
    ${test9}      Time Check    ${COMPORT}    9
    Should Contain    ${test9}    PASS
    Get Slot Status 9
    Sleep    5

Test : Test card no card 10
    [Tags]  Check status card
    ${test10}      Time Check    ${COMPORT}    10
    Should Contain    ${test10}    PASS
    Get Slot Status 10
    Sleep    5

Test : card no card 9 from Standby
    [Tags]  Check status card from Standby
    Open Browser And Login 2
    Sleep   10
    Welcome Page Should Be Open
    Sleep    5
    Page Should Contain    Standby CE
    Go to HW
    Sleep    2
    Refresh button
    Sleep    5
    Select Frame    name:main
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[9]/td[3]
    ${cardS1}        Get Text    //*[@id="slotTableContentTbody"]/tr[9]/td[3]
    Should Contain    ${cardS1}    Ethernet
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[9]/td[7]
    ${cardS2}        Get Text    //*[@id="slotTableContentTbody"]/tr[9]/td[7]
    Should Contain    ${cardS2}    -
    Sleep    5

Test : Test card no card 10 from Standby
    [Tags]  Check status card from Standby
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[10]/td[3]
    ${cardS3}        Get Text    //*[@id="slotTableContentTbody"]/tr[10]/td[3]
    Should Contain    ${cardS3}    Ethernet
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[10]/td[7]
    ${cardS4}        Get Text    //*[@id="slotTableContentTbody"]/tr[10]/td[7]
    Should Contain    ${cardS4}    -
    Sleep    5


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
${URL}        http://192.168.0.33/index.htm
${URL2}        http://192.168.0.44/index.htm
${IPA}        192.168.0.33
${IPB}        192.168.0.44
${BROWSER}          Chrome
${COMPORT}          COM3
${fpga}     111
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
    [Tags]  Open and find info on Active by web
    Open Browser And Login
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
    Sleep    5
    Page Should Contain    Standby CE
    Sleep    5
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

Test 3: Check sh version
    [Tags]  Check version
    ${test1}      Parse    ${COMPORT}      ${SWVer}     ${version}     ${fpga}
    Should Contain    ${test1}    3

Test 4: Check login and ping Active
    Open Browser And Login
    Sleep    5
    Page Should Contain    Active CE
    Sleep    5
    Ping
    Select Frame    name:main
    Input Text    //*[@id="ip_addr"]    ${IPA}
    Sleep    5
    Click Button    Start
    Sleep    15
    Unselect Frame
    Page Should Contain    PING ${IPA}  (${IPA}): 56 data bytes
    Page Should Contain    5 packets transmitted, 5 packets received, 0% packet loss
    Page Should Contain    Ping session completed.
    Sleep    5
    Select Frame    name:main
    Click Button     ${SPACE}New Ping${SPACE}
    Sleep    5
    Input Text    //*[@id="ip_addr"]    ${IPB}
    Sleep    5
    Click Button    Start
    Sleep    15
    Unselect Frame
    Page Should Contain    PING ${IPB}  (${IPB}): 56 data bytes
    Page Should Contain    5 packets transmitted, 5 packets received, 0% packet loss
    Page Should Contain    Ping session completed.
    Go to main
    Sleep    5

Test 5: Check login and ping Standby
    Open Browser And Login 2
    Sleep    5
    Page Should Contain    Standby CE
    Sleep    5
    Ping
    Select Frame    name:main
    Input Text    //*[@id="ip_addr"]    ${IPB}
    Sleep    5
    Click Button    Start
    Sleep    15
    Unselect Frame
    Page Should Contain    PING ${IPB}  (${IPB}): 56 data bytes
    Page Should Contain    5 packets transmitted, 5 packets received, 0% packet loss
    Page Should Contain    Ping session completed.
    Sleep    5
    Select Frame    name:main
    Click Button     ${SPACE}New Ping${SPACE}
    Sleep    5
    Input Text    //*[@id="ip_addr"]    ${IPA}
    Sleep    5
    Click Button    Start
    Sleep    15
    Unselect Frame
    Page Should Contain    PING ${IPA}  (${IPA}): 56 data bytes
    Page Should Contain    5 packets transmitted, 5 packets received, 0% packet loss
    Page Should Contain    Ping session completed.
    Go to main
    Sleep    5

Test 6: Check power card from cli
    ${testpower1}    Power Card Check    ${COMPORT}    ${activepw}
    Should Be Equal    ${testpower1}    2
    Sleep    10
    ${testpower2}    Power Card Check    ${COMPORT}    ${standbypw}
    Should Be Equal    ${testpower2}    1

Test 7: Active PW Web Status on Active CE
    Open Browser And Login
    Sleep    5
    Go to HW
    Sleep    5
    Select Frame    name:main
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[7]/td[1]
    ${test1}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[1]
    Should Be Equal    ${test1}    ${activepw}
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[7]/td[2]  
    ${test2}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[2]
    Should Be Equal    ${test2}    PWR 48VBE
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[7]/td[3]  
    ${test3}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[3]
    Should Be Equal    ${test3}    PWR 48VBE
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[7]/td[6]
    ${test4}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[6]
    Should Be Equal    ${test4}    Operational*
    Sleep    5

Test 8: Standby PW Status on Standby CE
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[8]/td[1]
    ${test11}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[1]
    Should Be Equal    ${test11}    ${standbypw}
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[8]/td[2]  
    ${test22}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[2]
    Should Be Equal    ${test22}    PWR 48VBE
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[8]/td[3]  
    ${test33}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[3]
    Should Be Equal    ${test33}    PWR 48VBE
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[8]/td[6]
    ${test44}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[6]
    Should Be Equal    ${test44}    Operational
    Sleep    5

Test 9: Active PW Web Status on Standby CE
    Open Browser And Login 2
    Sleep    5
    Go to HW
    Sleep    5
    Select Frame    name:main
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[7]/td[1]
    ${test31}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[1]
    Should Be Equal    ${test31}    ${activepw}
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[7]/td[2]  
    ${test32}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[2]
    Should Be Empty    ${test32}
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[7]/td[3]  
    ${test33}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[3]
    Should Be Equal    ${test33}    PWR 48VBE
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[7]/td[7]
    ${test34}    Get Text    //*[@id="slotTableContentTbody"]/tr[7]/td[7]
    Should Be Equal    ${test34}    -
    Sleep    5

Test 10: Standby PW Web Status on Standby CE
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[8]/td[1]
    ${test41}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[1]
    Should Be Equal    ${test41}    ${standbypw}
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[8]/td[2]  
    ${test42}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[2]
    Should Be Empty    ${test42}
    Element Should Be Visible  //*[@id="slotTableContentTbody"]/tr[8]/td[3]  
    ${test43}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[3]
    Should Be Equal    ${test43}    PWR 48VBE
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[8]/td[7]
    ${test44}    Get Text    //*[@id="slotTableContentTbody"]/tr[8]/td[7]
    Should Be Equal    ${test44}    -
    Sleep    5
    Unselect Frame
    Close All Browsers

Test 11: Test Standby HW 
    ${test7}    Ssh Card Status    ${IPB}    7    False
    Should Be Equal    ${test7}    1
    Sleep    5
    ${test8}    Ssh Card Status    ${IPB}    8    False
    Should Be Equal    ${test8}    1

Test 12: Test the card state
    [Tags]  Slot status
    Open Browser And Login
    Sleep    5
    Go to HW
    Sleep    5
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
    Sleep    5
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
    Sleep    5
    Unselect Frame

Test 13: Test card no card 9
    [Tags]  Check status card
    Refresh button
    Sleep    5
    ${test9}      Time Check    ${COMPORT}    9
    Should Contain    ${test9}    PASS
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
    Sleep    5
    Unselect Frame

Test 14: Test card no card 10
    [Tags]  Check status card
    ${test10}      Time Check    ${COMPORT}    10
    Should Contain    ${test10}    PASS
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
    Sleep    5

Test 15: Test card no card 9 from Standby
    Open Browser And Login 2
    Sleep    5
    Go to HW
    Sleep    5
    Select Frame    name:main
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[9]/td[3]
    ${cardS1}        Get Text    //*[@id="slotTableContentTbody"]/tr[9]/td[3]
    Should Contain    ${cardS1}    Ethernet
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[9]/td[7]
    ${cardS2}        Get Text    //*[@id="slotTableContentTbody"]/tr[9]/td[7]
    Should Contain    ${cardS2}    -
    Sleep    5

Test 16: Test card no card 10 from Standby
    [Tags]  Check status card from Standby
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[10]/td[3]
    ${cardS3}        Get Text    //*[@id="slotTableContentTbody"]/tr[10]/td[3]
    Should Contain    ${cardS3}    Ethernet
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[10]/td[7]
    ${cardS4}        Get Text    //*[@id="slotTableContentTbody"]/tr[10]/td[7]
    Should Contain    ${cardS4}    -
    Sleep    5

Test 17: Status card from Standby for testing standby web UI
    Sleep    5
    Element Should Be Visible    //*[@id="slotTableContentTbody"]/tr[3]/td[2]
    ${cardfromstandby}    Get Text    //*[@id="slotTableContentTbody"]/tr[3]/td[2]
    Should Be Empty    ${cardfromstandby}

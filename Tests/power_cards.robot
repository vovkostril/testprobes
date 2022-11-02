*** Settings ***
Documentation       Check power cards
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Library        ../Libs/test_parse.py
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
${PORT}        COM3
${username}     admin
${FPGA2}        1
${REVISION}     2744
${SWVer}          CM Native CE R4.4
${activepw}          7
${standbypw}          8

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

*** Test Cases ***
Test 0: Check login and ping Active
    Open Browser And Login
    Sleep   10
    Welcome Page Should Be Open
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
    # Current Frame Should Contain    main
    # Element Should Be Visible    body > form > input[type=submit]
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

Test 1: Check login and ping Standby
    Open Browser And Login 2
    Sleep   10
    Welcome Page Should Be Open
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
    # Current Frame Should Contain    main
    # Element Should Be Visible    body > form > input[type=submit]
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
    # Close Browser
    # Click Element    locator

Test 2: Check power card from cli
    ${testpower1}    Power Card Check    ${COMPORT}    ${activepw}
    Should Be Equal    ${testpower1}    2
    Sleep    10
    ${testpower2}    Power Card Check    ${COMPORT}    ${standbypw}
    Should Be Equal    ${testpower2}    1

Test 3: Active PW Web Status on Active CE
# TODO: create IF
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
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

Test 4: Standby PW Status on Standby CE
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

Test 5: Active PW Web Status on Standby CE
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
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

Test 6: Standby PW Web Status on Standby CE
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

Test 7: Test Standby HW 
    ${test7}    Ssh Card Status    ${IPB}    7    False
    Should Be Equal    ${test7}    1
    Sleep    5
    ${test8}    Ssh Card Status    ${IPB}    8    False
    Should Be Equal    ${test8}    1

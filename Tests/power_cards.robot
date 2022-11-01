*** Settings ***
Documentation       Check power cards
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
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

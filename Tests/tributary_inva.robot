*** Settings ***
Documentation       New test PTP by web
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Library             ../Libs/card.py
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
${URL2}        http://192.168.0.4/index.htm
${BROWSER}          Chrome
${COMPORT}          COM3

*** Keywords ***
Open Browser To Login Page
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Title Should Be    Login

Open Browser To Login Page 2
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
    Title Should Be    Login

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
    Page Should Contain    Connection Master

Go to HW
    Select Frame    name:main
    Current Frame Should Contain    main
    Wait Until Element Is Visible    //*[@id="hwiButton"]/input
    Click Element    //*[@id="hwiButton"]/input
    Sleep    2
    Page Should Contain    Hardware Inventory
    Unselect Frame

Get Slot Status
    Select Frame    name:main
    Element Should Be Visible   //*[@id="unitTableContentTbody"]/tr/td[1]
    ${loc}        Get Text    //*[@id="unitTableContentTbody"]/tr/td[1]
    Should Contain    ${loc}    16 Slot Subrack
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[3]/td[2]
    ${card1}        Get Text    //*[@id="slotTableContentTbody"]/tr[3]/td[2]
    Should Contain    ${card1}    CE8+
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[3]/td[3]
    ${card2}        Get Text    //*[@id="slotTableContentTbody"]/tr[3]/td[3]
    Should Contain    ${card2}    CE8+
    Element Should Be Visible   //*[@id="slotTableContentTbody"]/tr[3]/td[6]
    ${card3}        Get Text    //*[@id="slotTableContentTbody"]/tr[3]/td[6]
    Should Contain    ${card3}    Operational
    Unselect Frame

Refresh button
    Select Frame    name:main
    Sleep    5
    # Wait Until Element Is Visible    /html/body/div[1]
    Click Button    Refresh
    Sleep    5
    Wait Until Element Is Visible    //*[@id="autorefresh"]
    Click Element    //*[@id="autorefresh"]
    Unselect Frame

*** Test Cases ***
Open and click
    [Documentation]    Ptp test via WEB
    [Tags]  Active master ptp
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
    Input Username      admin
    Submit Credentials
    Welcome Page Should Be Open
    Sleep    5
    Page Should Contain    Active CE

Go to hardware
    Go to HW
    Sleep    2

Test the card state
    Get Slot Status
    Sleep    2

Test card no card
    Card    ${COMPORT}    10
    Refresh button
    Sleep    20



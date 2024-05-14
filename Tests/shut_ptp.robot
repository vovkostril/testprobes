*** Settings ***
Documentation       New test PTP by web
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Library             ../Libs/shut_nocard.py
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${BROWSER}          Chrome
${KERA}          COM3

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
    # Title Should Be    Stack Overflow - Where Developers Learn, Share, & Build Careers

Ptp monitor
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="menu"]/tbody/tr[2]/td/ul/li[2]/details/summary
    # Click Element   //*[@id="menu"]/tbody/tr[2]/td/ul/li[2]/details/summary
    Sleep    5
    Click Element    //*[@id="ptp.htm"]
    Sleep    15
    Page Should Contain    PTP Clock Configuration

Click on Main Page
    Sleep    10
    Select Frame    name:top
    Current Frame Should Contain    top
    Element Should Be Visible   //*[@id="logotext"]
    Element Should Be Visible   //ul/li[3]
    Element Should Be Visible   //ul/li[3]/div/a[1]
    Click Element   //ul/li[3]/div/a[1]
    Sleep    10

Click PTP instance
    Sleep    10
    Select Frame    name:main
    Element Should Be Visible   //*[@id="ptpData"]/tr[3]/td[1]/a
    Click Element   //*[@id="ptpData"]/tr[3]/td[1]/a
    Sleep    10

Parse PTP phase
    Element Should Be Visible   //*[@id="CCDataSet_tbody"]/tr[2]/td[5]
    ${loc}        Get Text    //*[@id="CCDataSet_tbody"]/tr[2]/td[5]
    Should Contain    ${loc}    PHASE_LOCKED

Parse PTP time
    Element Should Be Visible   //*[@id="Lclock_tbody"]/tr/td[1]
    ${loc}        Get Text   //*[@id="Lclock_tbody"]/tr/td[1]
    Should Contain    ${loc}    2022

Parse PTP Rtm
    Element Should Be Visible   //*[@id="CCDataSet_tbody"]/tr[1]/th[1]
    ${loc}        Get Text    //*[@id="CCDataSet_tbody"]/tr[2]/td[1]
    Should Contain    ${loc}    1

Parse Port Shut
    Unselect Frame
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="menu"]/tbody/tr[2]/td/ul/li[1]/details/summary
    Click Element   //*[@id="menu"]/tbody/tr[2]/td/ul/li[1]/details/summary
    Sleep    2
    Click Element    //*[@id="ports.htm"]
    Sleep    2
    Page Should Contain    Port Configuration
    Unselect Frame

Press Refresh
    Select Frame    name:main
    Sleep    5
    # Wait Until Element Is Visible    /html/body/div[1]
    Click Button    Refresh
    Sleep    5
    Unselect Frame

*** Test Cases ***
Open and click
    [Documentation]    Ptp test via WEB
    [Tags]  Active master ptp
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
    Input Username      admin
    Submit Credentials
    Welcome Page Should Be Open
    Sleep    15
    Page Should Contain    Active CE
    Sleep    5

Ptp Go
    Ptp monitor
    Click PTP instance
    Parse PTP Phase

Ptp Atributes
    Parse PTP time
    Sleep    10
    Parse PTP Rtm

Ptp Shut Port
    Shut Down Port    ${KERA}    ${PORt}
    Parse Port Shut
    Sleep    5
    Press Refresh
    Up Down Port    ${KERA}    ${PORt}
    Sleep    5
    Press Refresh
    Ptp monitor
    Click PTP instance
    Parse PTP Phase

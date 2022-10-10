*** Settings ***
Documentation       New test PTP by web
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
${URL2}        http://192.168.0.4/index.htm
${BROWSER}          Chrome

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
    Should Contain    ${loc}    1970

Parse PTP Rtm
    Element Should Be Visible   //*[@id="CCDataSet_tbody"]/tr[1]/th[1]
    ${loc}        Get Text    //*[@id="CCDataSet_tbody"]/tr[2]/td[1]
    Should Contain    ${loc}    1


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
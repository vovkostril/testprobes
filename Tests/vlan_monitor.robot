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

# template
Ptp monitor
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="ptp.htm"]
    # Click Element   //*[@id="menu"]/tbody/tr[2]/td/ul/li[2]/details/summary
    Sleep    5
    Click Element    //*[@id="ptp.htm"]
    Sleep    15
    Page Should Contain    PTP Clock Configuration
    Unselect Frame

Vlan Monitor Probe To Open
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="Monitor_menu"]/details/ul/li[27]/details/summary/span
    # //*[@id="Monitor_menu"]/details/ul/li[27]/details/summary/span
    # Click Element   //*[@id="menu"]/tbody/tr[2]/td/ul/li[2]/details/summary
    Sleep    5
    Click Element    //*[@id="Monitor_menu"]/details/ul/li[27]/details/summary/span
    Sleep    5
    Click Element    //*[@id="vlan_port_stat.htm"]
    Unselect Frame

*** Test Cases ***
Open and click
    [Documentation]    Test via WEB
    [Tags]  Active
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Input Username      admin
    Submit Credentials
    Welcome Page Should Be Open
    Sleep    15
    Page Should Contain    Active CE
    Sleep    5

# Ptp Go
#     Ptp monitor
Check the Vlan Monitor Posibility
    Vlan Monitor Probe To Open

Click to Ports tab and check the field of 
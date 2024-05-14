*** Settings ***
Documentation       New test PTP by web
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
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

Vlan Config Page Open
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="Configuration_menu"]/details/summary/span
    Click Element    //*[@id="Configuration_menu"]/details/summary/span
    Sleep    5
    Element Should Be Visible    //*[@id="Configuration_menu"]/details/ul/li[38]/details/summary/span
    Click Element    //*[@id="Configuration_menu"]/details/ul/li[38]/details/summary/span
    Sleep    5
    Click Element    //*[@id="vlan.htm"]
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
    Skip
    Vlan Monitor Probe To Open

Click to Ports tab and check the field of vlans
    Skip
    Sleep    10
    Page Should Contain    VLAN Port Status for Combined users
    Sleep    5
    Select Frame    name:main
    Element Should Be Visible    //*[@id="port_table_body"]/tr[43]/td[1]
    Element Should Be Visible    //*[@id="port_table_body"]/tr[43]/td[5]
    ${r1}    Get Text    //*[@id="port_table_body"]/tr[43]/td[5]
    Should Contain    ${r1}    1

Config check the Vlan Port
    Vlan Config Page Open
    Sleep    5
    Page Should Contain    Port VLAN Configuration
    Select Frame    name:main
    ${r1}    Get Value    //*[@id="vlans"]
    Sleep    5
    Element Should Be Visible    //*[@id="vlan_port_body"]/tr[41]/td[2]
    ${r2}    Get Text    //*[@id="vlan_port_body"]/tr[41]/td[2]
    ${r3}    Get Value    //*[@id="alw_vids_224"]
    ${r4}    Get Value    //*[@id="mode_224"]
    Unselect Frame


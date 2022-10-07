*** Settings ***
Documentation       New test by web
Library             SeleniumLibrary
# Library             ../Libs/probe_gui.py
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
${BROWSER}          Chrome

*** Keywords ***
Open Browser To Login Page
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
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
    Title Should Be    Connection Master
    # Title Should Be    Stack Overflow - Where Developers Learn, Share, & Build Careers

Test the iframes
    Select Frame    name:main
    Current Frame Should Contain    main
    Wait Until Element Is Visible    //*[@id="hwiButton"]/input
    Click Element    //*[@id="hwiButton"]/input
    Sleep    20
    Page Should Contain    Hardware Inventory

Test side left
    Select Frame    name:contents
    Wait Until Element Is Visible   //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Click Element    //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Sleep    5
    Click Element    //*[@id="ping4.htm"]
    Sleep    15
    Page Should Contain    Ping (IPv4)

Click on Main Page
    Sleep    10
    Select Frame    name:top
    Current Frame Should Contain    top
    Element Should Be Visible   //*[@id="logotext"]
    # Element Should Be Visible   //ul/li[3]
    Element Should Be Focused   //ul/li[3]
    Click Element   //ul/li[3]
    #               /html/body/toprow/ul
    #               //ul/li[3]
    Sleep    10

#Parse HW

*** Test Cases ***
Open and click
    [Documentation]    Try to use locators
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Input Username      admin
    Submit Credentials
    Welcome Page Should Be Open
    Sleep    20
    Test the iframes
    Sleep    5

# Test Ping Finally
#    Test side left
#    Select Frame    name:main
#    Current Frame Should Contain    main
#    Sleep   5
#    Input Text    //*[@id="ip_addr"]    192.168.0.4
#    Sleep    5
#    Click Button    Start
#    Sleep    15
#    Page Should Contain    PING 192.168.0.4 (192.168.0.4): 56 data bytes
#    Page Should Contain    5 packets transmitted, 5 packets received, 0% packet loss
#    Page Should Contain    Ping session completed.

Test go to main page
    Click on Main Page
    Sleep    10
    Welcome Page Should Be Open
    Page Should Contain    Connection Master Carrier Ethernet
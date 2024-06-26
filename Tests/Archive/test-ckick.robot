*** Settings ***
Documentation       New test by web
Library             SeleniumLibrary
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${LOGIN URL}        http://192.168.0.33/
${PING URL}         http://192.168.0.34/ping4.htm
${BROWSER}          Chrome

*** Keywords ***
Open Browser To Login Page
    Open Browser        ${LOGIN URL}        ${BROWSER}      alias=tab1
    Title Should Be    Login

Open Browser To Ping Page
    Open Browser        ${PING URL}        ${BROWSER}       alias=tab2
    # Title Should Be    Ping

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

Ping Page Should Be Open
    Title Should Be    Login
# Click the refresh button
#     Click Button    css:#refreshbar > form > input[type=button]:nth-child(5)
    # #refreshbar > form > input[type=button]:nth-child(5)
    # document.querySelector('#refreshbar > form > input[type=button]:nth-child(5)');

*** Test Cases ***
Open and click
    [Documentation]    Try to login and click the ping url to be opened
    Open Browser        ${LOGIN URL}        ${BROWSER}      alias=tab1
    Input Username      admin
    Submit Credentials
    Welcome Page Should Be Open
    Page Should Contain    HW Inventory
    Maximize Browser Window
    Sleep    10
    # Wait Until Page Contains Element    //*[@id="hostName"]    timeout=30
    Wait Until Page Contains Element    css:#headlineHostname   timeout=50
    # Wait Until Page Contains Element    css:#hwiButton > input[type=button]    timeout=50
    # Click Element    //*[@id="hwiButton"]
    # Wait Until Page Contains Element    xpath://input[@id="hwiButton"]    timeout=50
    # Wait Until Page Contains Element    xpath://*[@id="hwiButton"]/input    timeout=50
    # Set Focus To Element    css:#hwiButton > input[type=button]
    # Click Image    xpath=(//*[@id="slot_div"]/div[1]/img)
    # Wait Until Element Is Visible    xpath://*[@id="refreshbar"]/form/label    timeout=3
    # Press Keys    xpath://*[@id="refreshbar"]/form/label    SPACE
    # //*[@id="refreshbar"]/form/label
    # Set Focus To Element    xpath=//input[@id='hwiButton']
    # //*[@id="autorefresh"]
    # Wait Until Element Is Visible    xpath://*[@id="hwiButton"]/input
    # Click Element    xpath://*[@id="refreshbar"]/form/input[2]
    # Click Element    xpath://*[@id="hwiButton"]
#    ${e} Get WebElement //*[@id="hwiButton"]
#    [Return] ${e}
    # Input Text    xpath://*[@id="hwiButton"]/input    RETURN
    # Wait Until Element Is Visible    id:"hwiButton"
    # Click Button    xpath://*[@id="hwiButton"]
    # Wait Until Element Is Visible    xpath://*[@id="hwiButton"]/input
    # Wait Until Element Is Visible    id=hwiButton
    # /html/body/div[2]/form/div/input
    # #hwiButton > input[type=button]
    # //*[@id="hwiButton"]
    # /html/body/div[2]/form/div //*[@id="hwiButton"]
    # Wait Until Element Is Visible    value:"HW Inventory"
    # Click Link    xpath="ping4.htm" //*[@id="hwiButton"]
    # ${elem} =	Get WebElement	id:ping4.htm
    # ${elem} =	Get WebElement	name:"ptp.htm"
    # Click Element    ${elem}
    # Click Button    value:"HW Inventory"
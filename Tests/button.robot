*** Settings ***
Documentation       New test by web
Library             SeleniumLibrary
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
# ${URL}        https://stackoverflow.com/
${BROWSER}          Chrome
${selector1}        xpath://*[@id="hwiButton"]/input
${locator}          html > frameset > frameset > frame:nth-child(2)

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

Click Button HW
    Click Element At Coordinates    ${selector1}    ${1}    ${6}

Get element by
    Get WebElement   ${locator}

Label Locator Strategy
    [Arguments]  ${browser}  ${locator}
    ${id} =  get element attribute  xpath=//label[text()='${locator}']  for
    ${element} =  get webelement  id=${id}
    [Return]	${element}

Test the iframes 
    Select Frame    name:main
    Current Frame Should Contain    main
    Wait Until Element Is Visible    //*[@id="hwiButton"]/input
    Click Element    //*[@id="hwiButton"]/input
    Sleep    20
    Page Should Contain    Hardware Inventory

Test side left
    Select Frame    name:content
    Current Frame Should Contain    content
    Wait Until Element Is Visible   //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Click Element    //*[@id="menu"]/tbody/tr[2]/td/ul/li[3]/details/summary
    Sleep    5
    Click Element    //*[@id="ping4.htm"]
    Sleep    15
    Page Should Contain    Ping (IPv4)

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
    Test side left
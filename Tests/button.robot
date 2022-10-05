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
    Get WebElement   id:hwiButton

*** Test Cases ***
Open and click
    [Documentation]    Try to use locators
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Input Username      admin
    Submit Credentials
    Welcome Page Should Be Open
    Sleep    20
    # Click Button HW
    Wait Until Element Is Visible    ${selector1}       timeout=10
    # Get element by
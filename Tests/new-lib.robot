*** Settings ***
Documentation       New test by webBrowser
Library             Browser
Test Timeout        2 minute
# TODO FOR DYNa

*** Variables ***
${URL}        http://192.168.0.3/index.htm
# ${URL}        https://stackoverflow.com/
${BROWSER}          Chrome
${selector1}

*** Keywords ***
Submit Form
    Click    body > form > button

Click HW
    Click    \#hwiButton > input[type=button]

Get HW
    # Get Element    css=.class > \body > toprow > ul > li:nth-child(1) > div
    # Get Element    css=.class > #int_port_div > div
    # Get Element    css=.class > #hwiButton
    # Click    //*[contains(text(), "HW Inventory")]
    # Click    "Login" >> xpath=../input
    # Get Element    body > toprow > ul > li:nth-child(1) > div > img
    # #hwiButton body > toprow > ul > li:nth-child(1) > div
    # Get Element    html > frameset > frameset > frame:nth-child(2)
    Get Element    body > toprow > ul > li:nth-child(3) > div > input[type=image]
    # body > toprow > ul > li:nth-child(3) > div > a:nth-child(3) > img
    # body > toprow > ul > li:nth-child(3) > div > input[type=image]
    # Get Element    \#menu > tbody > tr:nth-child(2) > td > ul > li:nth-child(2) > details > ul > li:nth-child(1) > details > summary

Get Text For
    Get Text    HW Inventory

*** Test Cases ***
Open and run
    New Page        ${URL}
    Type Text    body > form > input:nth-child(1)    admin
    Submit Form
    Sleep    20
    Get HW
    # xpath: //*[contains(text(), "HW Inventory")]
    # #body

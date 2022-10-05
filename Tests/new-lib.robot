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
    # Get Element    \#hwiButton > input[type=button]
    Get Element    body > toprow > ul > li:nth-child(1) > div > img

*** Test Cases ***
Open and run
    New Page        ${URL}
    # Type Text    input#user    admin
    Type Text    body > form > input:nth-child(1)    admin
    # body > form > input:nth-child(1)
    # Click    button=submit
    # #refreshbar > form > input[type=button]:nth-child(5)
    Submit Form
    Sleep    20
    # Click HW
    Get HW
    # #alarmStatus > tr > td #alarmStatus > tr > a > img body > toprow > ul > li:nth-child(1) > div > img
*** Settings ***
Library    RPA.Browser.Playwright
# Library    RPA.Browser.Selenium

*** Variables ***
${port}    176
${vlan}    91
${slot}    12
${url_active}    http://192.168.0.3
${url_standby}    http://192.168.0.4

*** Keywords ***
Open browser and login
    [Arguments]    ${url}
    New Page    ${url}
    Sleep    2
    Take Screenshot
    ${usename}=    Set Variable    xpath=/html/body/form/input[1]
    Type Text    ${usename}    admin
    ${locator}=    Set Variable    xpath=/html/body/form/button
    Click    ${locator}
    Sleep    5
    Take Screenshot
    Sleep    5

Go to ports
    [Arguments]    ${url}
    Open browser and login    ${url}
    Click    html > frameset > frameset > frame:nth-child(1) >>> #Configuration_menu > details > summary > span
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="ports.htm"]
    Sleep    2
    Scroll To Element  html > frameset > frameset > frame:nth-child(2) >>> //*[@id="portData"]/tr[52]/td[1]
    Take Screenshot
    Sleep    2
    Close Browser

*** Test Cases ***
Test 1: Check the PTP Status Config
    Set Browser Timeout    2m
    Open browser and login    ${url_active}
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="Configuration_menu"]/details/summary/span
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="ptp.htm"]
    Sleep    2
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="ptpData"]/tr[3]/td[1]/a
    Take Screenshot
    Close Browser

Test 2: Check the PTP Status Monitor
    Open browser and login    ${url_active}
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="ptp.htm"]
    Sleep    2
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="ptpData"]/tr[3]/td[1]/a
    Take Screenshot
    Close Browser
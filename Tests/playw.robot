*** Settings ***
Library    RPA.Browser.Playwright
# Library    RPA.Desktop
# Library    RPA.Browser.Selenium

*** Tasks ***
Playwright: Open a browser in headless mode
    New Page    url=http://192.168.0.3
    # Set Browser Timeout    2m
    Sleep    2
    Take Screenshot
    ${usename}=    Set Variable    xpath=/html/body/form/input[1]
    Type Text    ${usename}    admin
    ${locator}=    Set Variable    xpath=/html/body/form/button
    Click    ${locator}
    Sleep    5
    Take Screenshot

# Test 1: Check the vlans that were applied to thu port_table_body
    Sleep    5
    Set Browser Timeout    2m
    Click    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="hwiButton"]/input
    Sleep    5   
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(1) >>> #Configuration_menu > details > summary > span
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(1) >>> #Configuration_menu > details > ul > li:nth-child(38) > details > summary > span
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="vlan.htm"]
    Sleep    2
    Take Screenshot
    
# Test 2: Check Monitor Value of VID for port
    Click    html > frameset > frameset > frame:nth-child(1) >>> #Monitor_menu > details > ul > li:nth-child(27) > details > summary > span
    Sleep    2
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="vlan_port_stat.htm"]
    Sleep    2
    # ${r1}    Get Text    //*[@id="port_table_body"]/tr[41]/td[1]
    # ${r2}    Get Text    //*[@id="port_table_body"]/tr[41]/td[5]
    Take Screenshot


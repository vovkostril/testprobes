*** Settings ***
Library    RPA.Browser.Playwright
# Library    RPA.Browser.Selenium

*** Variables ***
${port}    176
${vlan}    91
${slot}    12
${url}    http://192.168.0.3

*** Keywords ***
Open browser and login
    New Page    url=${url}
    # Set Browser Timeout    2m
    Sleep    2
    Take Screenshot
    ${usename}=    Set Variable    xpath=/html/body/form/input[1]
    Type Text    ${usename}    admin
    ${locator}=    Set Variable    xpath=/html/body/form/button
    Click    ${locator}
    Sleep    5
    Take Screenshot
    Sleep    5
    Set Browser Timeout    2m

*** Tasks ***
Test 1 Playwright: Open a browser in headless mode
    Open browser and login
    Click    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="hwiButton"]/input
    Sleep    5   
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(1) >>> #Configuration_menu > details > summary > span
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(1) >>> #Configuration_menu > details > ul > li:nth-child(38) > details > summary > span
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="vlan.htm"]
    Sleep    2
    ${c1} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="vlans"]
    ${c2} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="vlan_port_body"]/tr[41]/td[1]
    #                                                                          //*[@id="vlan_port_body"]/tr[41]/td[1]
    ${c3} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="mode_192"]
    ${c4} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="pvid_192"]
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(1) >>> #Monitor_menu > details > ul > li:nth-child(27) > details > summary > span
    Sleep    2
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="vlan_port_stat.htm"]
    Sleep    2
    ${m1} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="port_table_body"]/tr[41]/td[5]
    ${m2} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> #port_table_body > tr:nth-child(41) > td:nth-child(1)
    Take Screenshot
    Close Browser

Test 2: Check the card 
    Open browser and login
    Click    html > frameset > frameset > frame:nth-child(1) >>> //*[@id="main.htm"]
    Sleep    2
    Take Screenshot
    Click    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="hwiButton"]/input
    Sleep    2
    Take Screenshot
    ${m1} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}]/td[2]
    ${m2} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}]/td[3]
    ${m3} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}]/td[6]
    ${m4} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}]/td[8]
    ${m5} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}+1]/td[2]
    ${m6} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}+1]/td[3]
    ${m7} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}+1]/td[6]
    ${m8} =    Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${slot}+1]/td[8]
    Set Browser Timeout    3m
    # Create List  ?
    FOR    ${counter}    IN RANGE    1    16
       "test" + ${counter}=     Get Text    html > frameset > frameset > frame:nth-child(2) >>> //*[@id="slotTableContentTbody"]/tr[${counter}]/td[2]
    END


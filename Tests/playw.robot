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
    ${test}    Set Variable    xpath=//*[@id="hwiButton"]/input
    ${locator_configmenu}=    Set Variable    xpath=//*[@id="Configuration_menu"]/details/summary/span
    ${locator_configmenuopen}=    Set Variable    xpath=//*[@id="vlan.htm"]
    ${locator_configvlans}=    Set Variable    xpath=//*[@id="Configuration_menu"]/details/ul/li[38]/details/summary/span
    # Take Screenshot
    Sleep    5
    # Find Element 
    # Click    name:contents >>> ${test}
    Click    name=main >>> selector=${test}
    Sleep    5   
    # Click    name:contents > ptp.htm
    Take Screenshot
    # Page Should Contain    Global VLAN Configuration
    # Page Should Contain    Port VLAN Configuration
    # Unselect Frame
    # Select Frame    name:main
    # Element Should Be Visible    //*[@id="vlan_port_body"]/tr[41]/td[2]
    # ${r1}    Get Text    //*[@id="vlan_port_body"]/tr[41]/td[2]
    # Element Should Be Visible    //*[@id="pvid_176"]
    # ${r2}    Get Value    //*[@id="pvid_176"]
    # Take Screenshot
    # Unselect Frame
    
Test 2: Check Monitor Value of VID for port
    Skip
    # Select Frame    name:contents
    ${locator_monitor}=    Set Variable    //*[@id="Monitor_menu"]/details/ul/li[27]/details/summary/span
    ${locator_monitorvlans}=    Set Variable    xpath=//*[@id="vlan_port_stat.htm"]
    Click    ${locator_monitor}
    Sleep    2
    Click    ${locator_monitorvlans}
    # Take Screenshot
    Sleep    2
    # Page Should Contain    VLAN Port Status for Combined users 
    # Unselect Frame
    # Select Frame    name:main
    # Element Should Be Visible    //*[@id="port_table_body"]/tr[41]/td[1]
    ${r1}    Get Text    //*[@id="port_table_body"]/tr[41]/td[1]
    # Element Should Be Visible    //*[@id="port_table_body"]/tr[41]/td[5]
    ${r2}    Get Text    //*[@id="port_table_body"]/tr[41]/td[5]
    # Take Screenshot
    # Unselect Frame


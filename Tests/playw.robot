*** Settings ***
Library    RPA.Browser.Playwright
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

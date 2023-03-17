*** Settings ***
Library    RPA.Browser.Playwright
# Library    RPA.Browser.Selenium

*** Tasks ***
Playwright: Open a browser in headless mode
    # Open Browser
    # Open Available Browser    http://192.168.0.3
    # New Browser    
    # New Page    http://192.168.0.3
    Open Browser    url=http://192.168.0.3    browser=chrome
    # New Page       http://192.168.0.3
    # Get Title      ==    Browser


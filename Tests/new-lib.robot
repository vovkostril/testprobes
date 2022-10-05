*** Settings ***
Documentation       New test by webBrowser
Library             Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.3/index.htm
# ${URL}        https://stackoverflow.com/
${BROWSER}          Chrome
${selector1}
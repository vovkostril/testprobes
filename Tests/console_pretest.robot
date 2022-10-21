*** Settings ***
Documentation       Pre-download tests
Library             ../Libs/pre_tests.py
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${PORT}        COM3
${FPGA2}        1
${REVISION}     2777
${SWVer}          CM Native CE R4.4

*** Test Cases ***
Test 1: Check sh version
    [Documentation]    Ptp test via WEB
    [Tags]  Active master ptp


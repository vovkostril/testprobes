*** Settings ***
Documentation       Pre-download tests
Library             ../Libs/pre_tests.py
Test Timeout        2 minute

*** Variables ***
${PORT}        COM3
${FPGA2}        1
${REVISION}     2744
${SWVer}          CM Native CE R4.4

*** Test Cases ***
Test 1: Check sh version
    [Tags]  Check version
    ${test1}      Parse    ${PORT}      ${SWVer}     ${REVISION}     ${FPGA2}
    Should Contain    ${test1}    3

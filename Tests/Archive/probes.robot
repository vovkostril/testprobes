*** Settings ***
Documentation       New test no card by web
Library    String
# Library             ../Libs/probe_gui.py
Library             ../Libs/test_parse.py
Library             ../Libs/pre_tests.py
Test Timeout        2 minute

*** Variables ***
${COMPORT}          COM3
${PORT}        COM3
${username}     admin
${FPGA2}        1
${REVISION}     2744
${SWVer}          CM Native CE R4.4

*** Test Cases ***
Test 0 : What the reason of life
    [Tags]  Check version
    ${test1}      Parse    ${PORT}      ${SWVer}     ${REVISION}     ${FPGA2}
    Should Contain    ${test1}    3

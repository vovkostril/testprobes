*** Settings ***
Library     ../Libs/tueth.py

*** Variables ***
${kera}=    COM3

*** Test Cases ***
Test eth
    [Tags]      Test eth cards in CM config
    ${test}=   Sh Hw    ${kera}
    Should Be Equal    ${test}    PASS
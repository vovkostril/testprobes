*** Settings ***
Documentation       Test IF construction
Library             SeleniumLibrary
Library    String
# Library             ../Libs/probe_gui.py
Library        ../Libs/test_parse.py
Library             ../Libs/pre_tests.py
Library    XML
Suite Teardown      Close Browser
Test Timeout        2 minute

*** Variables ***
${URL}        http://192.168.0.33/index.htm
${URL2}        http://192.168.0.44/index.htm
${IPA}        192.168.0.33
${IPB}        192.168.0.44
${BROWSER}          Chrome
${username}     admin
${titleLogin}        Login

*** Keywords ***
Open Browser And Login
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Title Should Be    Login
    Input Text    user    ${username}
    Click Button    Login

Open Browser And Login 2
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
    Title Should Be    Login
    Input Text    user    ${username}
    Click Button    Login

Welcome Page Should Be Open
    # Title Should Be    Dyna Wiz
    Page Should Contain    Connection Master

Go to HW
    Select Frame    name:main
    Current Frame Should Contain    main
    Wait Until Element Is Visible    //*[@id="hwiButton"]/input
    Click Element    //*[@id="hwiButton"]/input
    Sleep    2
    Page Should Contain    Hardware Inventory
    Unselect Frame

*** Test Cases ***
Test 0: Open and click
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Sleep    5
    ${title}        Get Title
    # IF    ${title} == ${titleLogin}

    IF    "${title}" == "${titleLogin}"
        Input Text    user    ${username}
        Click Button    Login
    ELSE
        Get Title
    END

Test 1: Open and click num 2
    Open Browser        ${URL2}        ${BROWSER}      alias=tab1
    Sleep    5
    ${title2}        Get Title

    IF    "${title2}" == "${titleLogin}"
        Input Text    user    ${username}
        Click Button    Login
    ELSE
        Get Title
    END

Test 2: Open and click and HW
    Open Browser        ${URL}        ${BROWSER}      alias=tab1
    Sleep    5
    ${title}        Get Title

    IF    "${title}" == "${titleLogin}"
        Input Text    user    ${username}
        Click Button    Login
    ELSE
        Sleep    5
        Go to HW
    END

 

*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Application
Test Teardown     Close Browser Instance

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Valid Login Workflow
    [Documentation]    Verify that login functionality works correctly with valid credentials
    Go To Login Page
    Input Login Credentials    ${USERNAME}    ${PASSWORD}
    Submit Login
    Verify Successful Login
    
Verify Reported Login Defect
    [Documentation]    Verify the reported defect where login results in white screen
    Go To Login Page
    Input Login Credentials    ${USERNAME}    ${PASSWORD}
    Submit Login
    Run Keyword And Expect Error    *    Verify Successful Login
    Capture Page Screenshot    white-screen-defect.png

*** Keywords ***
Open Browser To Application
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains    CURA Healthcare Service    timeout=10s
    Wait Until Page Contains    We Care About Your Health    timeout=10s

Close Browser Instance
    Close Browser

Go To Login Page
    Wait Until Element Is Visible    id=btn-make-appointment    timeout=10s
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=txt-username    timeout=10s
    Wait Until Page Contains Element    id=txt-password    timeout=10s

Input Login Credentials
    [Arguments]    ${username}    ${password}
    Input Text    id=txt-username    ${username}
    Input Text    id=txt-password    ${password}

Submit Login
    Click Element    id=btn-login
    Sleep    2s

Verify Successful Login
    Wait Until Page Contains Element    id=combo_facility    timeout=10s
    Page Should Contain Element    id=combo_facility
    Page Should Contain    Make Appointment
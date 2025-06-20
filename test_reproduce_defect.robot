 

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
Verify Login White Screen Issue
    Go To Login Page
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Click Login Button
    Capture Page Screenshot    login-result.png
    Run Keyword And Expect Error    *    Verify Booking Page Loaded

*** Keywords ***
Open Browser To Application
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains    CURA Healthcare Service
    Wait Until Page Contains    We Care About Your Health

Close Browser Instance
    Close Browser

Go To Login Page
    Wait Until Element Is Visible    id=btn-make-appointment
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=txt-username

Input Username
    [Arguments]    ${username}
    Input Text    id=txt-username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    id=txt-password    ${password}

Click Login Button
    Click Element    id=btn-login
    Sleep    3s

Verify Booking Page Loaded
    Wait Until Page Contains Element    id=combo_facility    timeout=5s
    Page Should Contain    Make Appointment
 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser Session

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Login Failure With John Doe User
    [Documentation]    Verify that login fails with John Doe credentials in UAT environment
    Navigate To Login Page
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Click Login Button
    Verify Login Failed

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Opens the browser and navigates to CURA Healthcare website
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains    CURA Healthcare Service    timeout=10s

Navigate To Login Page
    [Documentation]    Navigate to the login page
    Wait Until Element Is Visible    id=btn-make-appointment    timeout=10s
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=txt-username    timeout=10s

Input Username
    [Arguments]    ${username}
    [Documentation]    Enter username in the username field
    Input Text    id=txt-username    ${username}

Input Password
    [Arguments]    ${password}
    [Documentation]    Enter password in the password field
    Input Text    id=txt-password    ${password}

Click Login Button
    [Documentation]    Click on the login button
    Click Element    id=btn-login

Verify Login Failed
    [Documentation]    Verify that login has failed
    Wait Until Page Contains Element    id=txt-username    timeout=10s
    Page Should Contain Element    id=txt-username
    Page Should Not Contain    Make Appointment

Close Browser Session
    [Documentation]    Closes the current browser instance
    Close Browser
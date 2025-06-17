 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser web

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${LOGIN_URL}      https://katalon-demo-cura.herokuapp.com/login
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${VALID_USERNAME}  John Doe
${VALID_PASSWORD}  ThisIsAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Valid Login Test
    [Documentation]    Verify that a user can login with valid credentials
    Login With Valid Credentials
    Verify Login Success
    
Invalid Login Test
    [Documentation]    Verify that the reported bug exists - unable to login with John Doe
    Login With Invalid Credentials
    Verify Login Failure
    Page Should Contain    Login failed! Please ensure the username and password are valid.

Make Appointment After Login
    [Documentation]    Verify that a user can make an appointment after successful login
    Login With Valid Credentials
    Verify Login Success
    Make Appointment
    Verify Appointment Confirmation

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Opens the browser and navigates to login page with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Element Is Visible    id=btn-make-appointment    timeout=10s
    Click Element    id=btn-make-appointment
    Wait Until Element Is Visible    id=txt-username    timeout=10s

Close Browser web
    [Documentation]    Closes the current browser instance
    Close Browser

Login With Invalid Credentials
    [Documentation]    Attempts login with the reportedly invalid credentials
    Input Text    id=txt-username    ${USERNAME}
    Input Password    id=txt-password    ${PASSWORD}
    Click Button    id=btn-login

Login With Valid Credentials
    [Documentation]    Performs login with known valid credentials
    Input Text    id=txt-username    ${VALID_USERNAME}
    Input Password    id=txt-password    ${VALID_PASSWORD}
    Click Button    id=btn-login

Verify Login Success
    [Documentation]    Verifies successful login by checking for appointment form
    Wait Until Element Is Visible    id=appointment    timeout=10s
    Page Should Contain Element    id=appointment

Verify Login Failure
    [Documentation]    Verifies login failure
    Wait Until Element Is Visible    xpath=//p[contains(text(),'Login failed! Please ensure the username and password are valid.')]    timeout=10s

Make Appointment
    [Documentation]    Makes an appointment
    Select From List By Label    id=combo_facility    Hongkong CURA Healthcare Center
    Click Element    id=chk_hospotal_readmission
    Click Element    id=radio_program_medicaid
    Input Text    id=txt_visit_date    27/12/2023
    Input Text    id=txt_comment    Test appointment
    Click Button    id=btn-book-appointment

Verify Appointment Confirmation
    [Documentation]    Verifies that appointment was successfully created
    Wait Until Element Is Visible    xpath=//h2[contains(text(),'Appointment Confirmation')]    timeout=10s
    Page Should Contain    Appointment Confirmation
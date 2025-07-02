 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Healthcare
Test Teardown     Close Browser CURA

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${VALID_USERNAME}    John Doe
${VALID_PASSWORD}    ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Login Functionality with Valid Credentials
    [Documentation]    Test to verify the login functionality with valid credentials
    Verify Home Page Loaded
    Click Make Appointment Button
    Login With Valid Credentials
    Verify Login Status

*** Keywords ***
Open Browser To CURA Healthcare
    [Documentation]    Opens the browser and navigates to CURA Healthcare with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains    CURA Healthcare Service    timeout=10s

Verify Home Page Loaded
    [Documentation]    Verifies that the home page is loaded correctly
    Page Should Contain    CURA Healthcare Service
    Page Should Contain    We Care About Your Health

Click Make Appointment Button
    [Documentation]    Clicks on the Make Appointment button to navigate to login page
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=txt-username    timeout=10s

Login With Valid Credentials
    [Documentation]    Enters valid username and password and clicks login
    Input Text    id=txt-username    ${VALID_USERNAME}
    Input Text    id=txt-password    ${VALID_PASSWORD}
    Click Element    id=btn-login

Verify Login Status
    [Documentation]    Verifies if login was successful
    Wait Until Page Contains    Make Appointment    timeout=10s
    Page Should Contain    Make Appointment

Close Browser CURA
    [Documentation]    Closes the current browser instance
    Close Browser
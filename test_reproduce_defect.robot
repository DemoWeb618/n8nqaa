 
*** Settings ***
Library    SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Log Test Start
Test Teardown     Capture Page Screenshot On Failure

*** Variables ***
${URL}    https://katalon-demo-cura.herokuapp.com/
${BROWSER}    chrome
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")
${INVALID_USERNAME}    John Doe
${INVALID_PASSWORD}    ThisIsNotAPassword
${VALID_USERNAME}    John Doe
${VALID_PASSWORD}    ThisIsAPassword
${LOGIN_BUTTON}    id=btn-login
${MENU_TOGGLE}    id=menu-toggle
${LOGIN_LINK}    xpath=//a[contains(text(),'Login')]
${USERNAME_FIELD}    id=txt-username
${PASSWORD_FIELD}    id=txt-password
${APPOINTMENT_HEADER}    xpath=//h2[contains(text(),'Make Appointment')]

*** Test Cases ***
Verify Login Failure With Invalid Credentials
    Navigate To Login Page
    Enter Username    ${INVALID_USERNAME}
    Enter Password    ${INVALID_PASSWORD}
    Click Login Button
    Verify Login Failed

Verify Login Success With Valid Credentials
    Navigate To Login Page
    Enter Username    ${VALID_USERNAME}
    Enter Password    ${VALID_PASSWORD}
    Click Login Button
    Verify Login Success

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window

Navigate To Login Page
    Click Element    ${MENU_TOGGLE}
    Wait Until Element Is Visible    ${LOGIN_LINK}
    Click Element    ${LOGIN_LINK}
    Wait Until Element Is Visible    ${USERNAME_FIELD}

Enter Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Enter Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Verify Login Failed
    Page Should Contain Element    xpath=//p[contains(text(),'Login failed')]
    Capture Page Screenshot    login_failure.png

Verify Login Success
    Wait Until Element Is Visible    ${APPOINTMENT_HEADER}
    Page Should Contain Element    ${APPOINTMENT_HEADER}
    Capture Page Screenshot    login_success.png

Log Test Start
    Log    Starting test: ${TEST NAME}

Capture Page Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot    ${TEST NAME}_failure.png
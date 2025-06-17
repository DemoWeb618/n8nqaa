 
*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${MENU_TOGGLE}    id=menu-toggle
${LOGIN_LINK}     xpath=//a[@href='profile.php#login']
${USERNAME_FIELD}    id=txt-username
${PASSWORD_FIELD}    id=txt-password
${LOGIN_BUTTON}    id=btn-login
${ERROR_MESSAGE}    xpath=//p[contains(text(),'Login failed')]

*** Test Cases ***
Verify Login Issue
    [Documentation]    Verify that login fails with the specified credentials
    Navigate To Login Page
    Input Login Credentials    ${USERNAME}    ${PASSWORD}
    Click Login Button
    Verify Login Fails

Verify Successful Login And Transaction
    [Documentation]    Verify that login works with correct credentials and appointment can be made
    Navigate To Login Page
    Input Login Credentials    John Doe    ThisIsAPassword
    Click Login Button
    Verify Login Succeeds
    Make Appointment
    Verify Appointment Confirmation

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Opens the browser and navigates to the application homepage
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains Element    ${MENU_TOGGLE}    timeout=10s

Navigate To Login Page
    [Documentation]    Navigates to the login page
    Click Element    ${MENU_TOGGLE}
    Wait Until Element Is Visible    ${LOGIN_LINK}    timeout=10s
    Click Element    ${LOGIN_LINK}
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s

Input Login Credentials
    [Documentation]    Enters username and password
    [Arguments]    ${user}    ${pass}
    Input Text    ${USERNAME_FIELD}    ${user}
    Input Text    ${PASSWORD_FIELD}    ${pass}

Click Login Button
    [Documentation]    Clicks the login button
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s

Verify Login Fails
    [Documentation]    Verifies login failure message is displayed
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    timeout=10s
    Element Should Be Visible    ${ERROR_MESSAGE}
    Capture Page Screenshot    login_failure.png

Verify Login Succeeds
    [Documentation]    Verifies user is logged in successfully
    Wait Until Page Contains Element    xpath=//h2[contains(text(),'Make Appointment')]    timeout=10s
    Element Should Be Visible    xpath=//h2[contains(text(),'Make Appointment')]
    Capture Page Screenshot    login_success.png

Make Appointment
    [Documentation]    Creates a new appointment
    Select From List By Label    id=combo_facility    Tokyo CURA Healthcare Center
    Click Element    id=chk_hospotal_readmission
    Click Element    id=radio_program_medicare
    Input Text    id=txt_visit_date    30/12/2023
    Input Text    id=txt_comment    Test appointment
    Click Button    id=btn-book-appointment

Verify Appointment Confirmation
    [Documentation]    Verifies appointment was created successfully
    Wait Until Page Contains Element    xpath=//h2[contains(text(),'Appointment Confirmation')]    timeout=10s
    Element Should Be Visible    xpath=//h2[contains(text(),'Appointment Confirmation')]
    Page Should Contain    Tokyo CURA Healthcare Center
    Capture Page Screenshot    appointment_confirmation.png

Close Browser
    [Documentation]    Closes the current browser instance
    Close Browser
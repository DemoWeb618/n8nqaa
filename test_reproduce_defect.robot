 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Login Page
Test Teardown     Close All Browsers

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${VALID_USERNAME}  John Doe
${VALID_PASSWORD}  ThisIsAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Login With Invalid Credentials - Bug Reproduction
    [Documentation]    Test to reproduce the reported bug with white screen after login
    Navigate To Login Form
    Enter Login Credentials    ${USERNAME}    ${PASSWORD}
    Click Login Button
    Verify Login Result    fail

Verify Successful Login And Booking
    [Documentation]    Test successful login and booking functionality as a valid test case
    Navigate To Login Form
    Enter Login Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Login Button
    Verify Login Result    success
    Make Appointment
    Verify Appointment Confirmation

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Opens the browser and navigates to the application URL
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//a[@id='menu-toggle']    timeout=10s

Navigate To Login Form
    [Documentation]    Navigates to the login page
    Click Element    xpath=//a[@id='menu-toggle']
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Login')]
    Click Element    xpath=//a[contains(text(),'Login')]
    Wait Until Page Contains Element    id=txt-username    timeout=10s

Enter Login Credentials
    [Arguments]    ${username}    ${password}
    [Documentation]    Enters username and password in the login form
    Input Text    id=txt-username    ${username}
    Input Password    id=txt-password    ${password}

Click Login Button
    [Documentation]    Clicks on the login button
    Click Button    id=btn-login
    Sleep    2s    # Allow time for login processing

Verify Login Result
    [Arguments]    ${expected_result}
    [Documentation]    Verifies the login result
    Run Keyword If    "${expected_result}" == "success"    Run Keywords
    ...    Page Should Contain Element    id=appointment    AND
    ...    Page Should Contain    Make Appointment
    
    Run Keyword If    "${expected_result}" == "fail"    Run Keywords
    ...    Page Should Not Contain Element    id=appointment    AND
    ...    Capture Page Screenshot    login_fail.png

Make Appointment
    [Documentation]    Makes a test appointment
    Select From List By Label    id=combo_facility    Hongkong CURA Healthcare Center
    Select Checkbox    id=chk_hospotal_readmission
    Select Radio Button    programs    Medicare
    Input Text    id=txt_visit_date    30/04/2023
    Input Text    id=txt_comment    Test appointment
    Click Button    id=btn-book-appointment

Verify Appointment Confirmation
    [Documentation]    Verifies the appointment was successfully booked
    Wait Until Page Contains    Appointment Confirmation    timeout=10s
    Page Should Contain    Facility
    Page Should Contain    Hongkong CURA Healthcare Center
    Capture Page Screenshot    appointment_confirmation.png
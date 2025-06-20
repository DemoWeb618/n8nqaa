 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Website
Test Teardown     Close Browser

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify CURA Website Loading
    [Documentation]    Verify that CURA healthcare website loads successfully
    Page Should Contain    CURA Healthcare Service
    Page Should Contain Element    id=btn-make-appointment

Login Successfully
    [Documentation]    Verify successful login functionality
    Click Make Appointment Button
    Login With Valid Credentials
    Page Should Contain Element    id=appointment

Make Appointment Successfully
    [Documentation]    Verify appointment booking flow
    Click Make Appointment Button
    Login With Valid Credentials
    Select Healthcare Program    Medicare
    Check Hospital Readmission
    Select Date    27/12/2023
    Add Comment    This is a test appointment
    Click Book Appointment
    Verify Appointment Confirmation

*** Keywords ***
Open Browser To CURA Website
    [Documentation]    Opens the browser and navigates to CURA healthcare website
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains Element    id=btn-make-appointment    timeout=20s
    Set Selenium Timeout    30 seconds

Click Make Appointment Button
    [Documentation]    Clicks the Make Appointment button
    Wait Until Element Is Visible    id=btn-make-appointment
    Click Element    id=btn-make-appointment

Login With Valid Credentials
    [Documentation]    Login with valid username and password
    Wait Until Element Is Visible    id=txt-username
    Input Text    id=txt-username    ${USERNAME}
    Input Password    id=txt-password    ${PASSWORD}
    Click Button    id=btn-login

Select Healthcare Program
    [Arguments]    ${program}
    [Documentation]    Selects the specified healthcare program
    Wait Until Element Is Visible    id=combo_facility
    Select From List By Label    id=combo_facility    Tokyo CURA Healthcare Center
    Run Keyword If    '${program}' == 'Medicare'    Click Element    id=radio_program_medicare
    Run Keyword If    '${program}' == 'Medicaid'    Click Element    id=radio_program_medicaid
    Run Keyword If    '${program}' == 'None'    Click Element    id=radio_program_none

Check Hospital Readmission
    [Documentation]    Checks the hospital readmission checkbox
    Select Checkbox    id=chk_hospotal_readmission

Select Date
    [Arguments]    ${date}
    [Documentation]    Selects the appointment date
    Input Text    id=txt_visit_date    ${date}

Add Comment
    [Arguments]    ${comment}
    [Documentation]    Adds a comment to the appointment
    Input Text    id=txt_comment    ${comment}

Click Book Appointment
    [Documentation]    Clicks the Book Appointment button
    Click Button    id=btn-book-appointment

Verify Appointment Confirmation
    [Documentation]    Verifies the appointment confirmation page
    Wait Until Page Contains Element    xpath=//h2[contains(text(),'Appointment Confirmation')]
    Page Should Contain    Appointment Confirmation
    Page Should Contain Element    xpath=//a[contains(text(),'Go to Homepage')]
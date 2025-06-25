 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Healthcare
Test Teardown     Close Browser

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       NiphadaS
${PASSWORD}       ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Data Update Functionality
    [Documentation]    Test to verify if data can be updated in the SIT environment
    Login To Application    ${USERNAME}    ${PASSWORD}
    Make Appointment
    Verify Appointment Can Be Updated
    
*** Keywords ***
Open Browser To CURA Healthcare
    [Documentation]    Opens browser to CURA Healthcare application
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Element Is Visible    id:menu-toggle    timeout=10s

Login To Application
    [Documentation]    Login to the application with provided credentials
    [Arguments]    ${username}    ${password}
    Click Element    id:menu-toggle
    Wait Until Element Is Visible    xpath://a[contains(text(),'Login')]
    Click Element    xpath://a[contains(text(),'Login')]
    Input Text    id:txt-username    ${username}
    Input Text    id:txt-password    ${password}
    Click Element    id:btn-login
    Wait Until Element Is Visible    id:appointment    timeout=10s

Make Appointment
    [Documentation]    Create an appointment in the system
    Click Element    id:btn-make-appointment
    Wait Until Element Is Visible    id:combo_facility
    Select From List By Label    id:combo_facility    Seoul CURA Healthcare Center
    Click Element    id:chk_hospotal_readmission
    Click Element    id:radio_program_medicaid
    Input Text    id:txt_visit_date    25/06/2025
    Input Text    id:txt_comment    Initial appointment comment
    Click Element    id:btn-book-appointment
    Wait Until Page Contains    Appointment Confirmation    timeout=10s
    Page Should Contain Element    xpath://a[contains(text(),'Go to Homepage')]

Verify Appointment Can Be Updated
    [Documentation]    Verify that data can be updated in the system
    Click Element    xpath://a[contains(text(),'Go to Homepage')]
    Wait Until Element Is Visible    id:btn-make-appointment    timeout=10s
    Click Element    id:menu-toggle
    Wait Until Element Is Visible    xpath://a[contains(text(),'History')]    timeout=10s
    Click Element    xpath://a[contains(text(),'History')]
    Wait Until Page Contains    History    timeout=10s
    
    # Verify there's an appointment that can be modified
    Page Should Contain Element    xpath://div[contains(@class,'panel panel-info')]
    
    # Attempt to update the appointment
    Click Element    xpath://a[contains(text(),'Go to Homepage')]
    Wait Until Element Is Visible    id:btn-make-appointment    timeout=10s
    Click Element    id:btn-make-appointment
    
    # Update appointment data
    Wait Until Element Is Visible    id:combo_facility    timeout=10s
    Select From List By Label    id:combo_facility    Hongkong CURA Healthcare Center
    Click Element    id:radio_program_medicare
    Input Text    id:txt_visit_date    30/06/2025
    Input Text    id:txt_comment    Updated appointment comment
    Click Element    id:btn-book-appointment
    
    # Verify update was successful
    Wait Until Page Contains    Appointment Confirmation    timeout=10s
    Page Should Contain    Hongkong CURA Healthcare Center
    Page Should Contain    Medicare
    Page Should Contain    30/06/2025
    Page Should Contain    Updated appointment comment
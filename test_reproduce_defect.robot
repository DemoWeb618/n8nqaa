 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Login Page
Test Teardown     Close All Browsers

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Page Loading Issue
    [Documentation]    Verify if the page loads successfully and is not stuck in loading state
    Page Should Be Ready
    Page Should Contain    CURA Healthcare Service
    
Verify Login Functionality
    [Documentation]    Verify that login works with valid credentials
    Click Element    id=menu-toggle
    Wait Until Page Contains Element    xpath=//a[contains(text(),'Login')]
    Click Element    xpath=//a[contains(text(),'Login')]
    Input Text    id=txt-username    ${USERNAME}
    Input Text    id=txt-password    ${PASSWORD}
    Click Element    id=btn-login
    Wait Until Page Contains    Make Appointment    timeout=10s
    Page Should Contain    Make Appointment

Make Appointment
    [Documentation]    Verify that a user can make an appointment successfully
    Click Element    id=menu-toggle
    Wait Until Page Contains Element    xpath=//a[contains(text(),'Login')]
    Click Element    xpath=//a[contains(text(),'Login')]
    Input Text    id=txt-username    ${USERNAME}
    Input Text    id=txt-password    ${PASSWORD}
    Click Element    id=btn-login
    Wait Until Page Contains    Make Appointment    timeout=10s
    
    # Fill appointment form
    Select From List By Label    id=combo_facility    Tokyo CURA Healthcare Center
    Select Checkbox    id=chk_hospotal_readmission
    Click Element    xpath=//input[@value='Medicaid']
    Input Text    id=txt_visit_date    30/12/2023
    Input Text    id=txt_comment    Test appointment
    Click Button    id=btn-book-appointment
    
    # Verify appointment confirmation
    Wait Until Page Contains    Appointment Confirmation    timeout=10s
    Page Should Contain    Appointment Confirmation

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Opens the browser and navigates to the CURA Healthcare site
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    
Page Should Be Ready
    [Documentation]    Verifies that the page has loaded completely
    Wait Until Page Contains Element    xpath=//h1[contains(text(),'CURA Healthcare Service')]    timeout=20s
    Wait Until Element Is Visible    xpath=//h3[contains(text(),'We Care About Your Health')]    timeout=20s
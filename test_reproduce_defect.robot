 
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
    [Documentation]    Verify that the CURA Healthcare website loads correctly
    Wait Until Page Contains Element    id=btn-make-appointment    timeout=10s
    Page Should Contain    CURA Healthcare Service
    Page Should Contain Element    id=btn-make-appointment

Login to CURA Healthcare
    [Documentation]    Verify that login functionality works
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=txt-username    timeout=10s
    Input Text    id=txt-username    ${USERNAME}
    Input Text    id=txt-password    ${PASSWORD}
    Click Button    id=btn-login
    Wait Until Page Contains    Make Appointment    timeout=10s
    Page Should Contain Element    id=combo_facility

Make Appointment
    [Documentation]    Verify that appointment making functionality works
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=txt-username    timeout=10s
    Input Text    id=txt-username    ${USERNAME}
    Input Text    id=txt-password    ${PASSWORD}
    Click Button    id=btn-login
    Wait Until Page Contains    Make Appointment    timeout=10s
    Select From List By Label    id=combo_facility    Tokyo CURA Healthcare Center
    Click Element    id=chk_hospotal_readmission
    Click Element    id=radio_program_medicaid
    Input Text    id=txt_visit_date    27/12/2023
    Input Text    id=txt_comment    Test appointment
    Click Button    id=btn-book-appointment
    Wait Until Page Contains    Appointment Confirmation    timeout=10s
    Page Should Contain    Tokyo CURA Healthcare Center
    Page Should Contain    Yes
    Page Should Contain    Medicaid

*** Keywords ***
Open Browser To CURA Website
    [Documentation]    Opens the browser and navigates to CURA Healthcare website with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    20s
    
Close Browser
    [Documentation]    Closes the current browser instance
    SeleniumLibrary.Close Browser
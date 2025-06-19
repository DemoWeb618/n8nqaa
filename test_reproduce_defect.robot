 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Healthcare Website
Test Teardown     Close Browser

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify CURA Healthcare Website Loads Successfully
    [Documentation]    Verify that the CURA Healthcare website loads successfully
    Page Should Contain    CURA Healthcare Service
    Page Should Contain Element    id=menu-toggle
    Element Should Be Visible    xpath=//a[@id='btn-make-appointment']

Login To CURA Healthcare Successfully
    [Documentation]    Verify that login functionality works as expected
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=login    timeout=10s
    Input Text    id=txt-username    ${USERNAME}
    Input Password    id=txt-password    ${PASSWORD}
    Click Button    id=btn-login
    Wait Until Page Contains    Make Appointment    timeout=10s
    Page Should Contain Element    id=combo_facility

Make Appointment Successfully
    [Documentation]    Verify that appointment can be made successfully
    Click Element    id=btn-make-appointment
    Wait Until Page Contains Element    id=login    timeout=10s
    Input Text    id=txt-username    ${USERNAME}
    Input Password    id=txt-password    ${PASSWORD}
    Click Button    id=btn-login
    Wait Until Page Contains    Make Appointment    timeout=10s
    
    # Fill appointment form
    Select From List By Label    id=combo_facility    Seoul CURA Healthcare Center
    Click Element    id=chk_hospotal_readmission
    Click Element    xpath=//input[@value='Medicaid']
    Input Text    id=txt_visit_date    27/12/2023
    Input Text    id=txt_comment    This is a test appointment
    Click Button    id=btn-book-appointment
    
    # Verify appointment confirmation
    Wait Until Page Contains    Appointment Confirmation    timeout=10s
    Page Should Contain    Appointment Confirmation

*** Keywords ***
Open Browser To CURA Healthcare Website
    [Documentation]    Opens the browser and navigates to CURA Healthcare website with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    20s
    Wait Until Page Contains Element    xpath=//a[@id='btn-make-appointment']    timeout=15s
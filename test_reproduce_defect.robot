 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Application
Test Teardown     Close Browser Session

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${TIMEOUT}        30s

*** Test Cases ***
Verify CURA Healthcare Service Website Loads
    [Documentation]    Test to verify that the CURA Healthcare website loads successfully and doesn't display an infinite loading screen.
    Wait Until Page Contains    CURA Healthcare Service    timeout=${TIMEOUT}    error=Page didn't load within ${TIMEOUT} - infinite loading screen detected
    Page Should Contain    We Care About Your Health
    Page Should Contain Element    id=btn-make-appointment
    Click Element    id=btn-make-appointment
    
    # Verify navigation to login page works
    Wait Until Page Contains Element    id=txt-username    timeout=${TIMEOUT}
    Input Text    id=txt-username    ${USERNAME}
    Input Text    id=txt-password    ${PASSWORD}
    Click Element    id=btn-login
    
    # Verify successful login
    Wait Until Page Contains    Make Appointment    timeout=${TIMEOUT}

*** Keywords ***
Open Browser To Application
    [Documentation]    Opens the browser and navigates to CURA Healthcare website with specified options.
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Close Browser Session
    [Documentation]    Closes the current browser instance.
    Close Browser
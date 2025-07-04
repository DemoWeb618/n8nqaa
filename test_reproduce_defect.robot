 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Healthcare
Test Teardown     Close Browser Web

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify CURA Healthcare Service URL Opens Successfully
    [Documentation]    Verify that CURA Healthcare Service website loads successfully
    Title Should Be    CURA Healthcare Service
    Page Should Contain    CURA Healthcare Service
    Page Should Contain    We Care About Your Health
    Element Should Be Visible    id=btn-make-appointment

*** Keywords ***
Open Browser To CURA Healthcare
    [Documentation]    Opens the browser and navigates to CURA Healthcare Service with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    30s
    Wait Until Page Contains    CURA Healthcare Service    timeout=30s

Close Browser Web
    [Documentation]    Closes the current browser instance
    Close Browser
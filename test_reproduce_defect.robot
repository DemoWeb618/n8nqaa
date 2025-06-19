 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Website
Test Teardown     Close Browser web

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify CURA Website Loading
    [Documentation]    Verify that the CURA Healthcare website loads successfully.
    Title Should Be    CURA Healthcare Service
    Page Should Contain Element    id=btn-make-appointment

*** Keywords ***
Open Browser To CURA Website
    [Documentation]    Opens the browser and navigates to CURA Healthcare website with specified options.
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    30 seconds
    Wait Until Page Contains Element    id=btn-make-appointment    timeout=30s

Close Browser web
    [Documentation]    Closes the current browser instance.
    Close Browser
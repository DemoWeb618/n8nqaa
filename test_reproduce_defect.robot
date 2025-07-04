 
I'll create a Robot Framework script to reproduce and confirm the defect described in the Jira ticket. The script will follow the structure template and use Chrome headless on AWS EC2 Linux.

```
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Healthcare
Test Teardown     Close Browser Session

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${TIMEOUT}        30s

*** Test Cases ***
Verify CURA Healthcare Service URL Loads Successfully
    [Documentation]    Test to verify that the CURA Healthcare Service URL loads properly
    Wait Until Page Contains    CURA Healthcare Service    timeout=${TIMEOUT}
    Page Should Contain    We Care About Your Health
    Element Should Be Visible    id=btn-make-appointment
    
*** Keywords ***
Open Browser To CURA Healthcare
    [Documentation]    Opens the browser and navigates to CURA Healthcare Service with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Close Browser Session
    [Documentation]    Closes the current browser instance
    Close Browser
```
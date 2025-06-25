 
Based on the Jira ticket and requirements, I'll create a Robot Framework script to reproduce and confirm the issue with the CURA Healthcare demo website experiencing infinite loading.

```
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Healthcare
Test Teardown     Close Browser CURA

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")
${TIMEOUT}        20s

*** Test Cases ***
Verify CURA Healthcare Website Loads Successfully
    [Documentation]    Verify that the CURA Healthcare website loads successfully without infinite loading
    Wait Until Page Contains    CURA Healthcare Service    timeout=${TIMEOUT}
    Wait Until Page Contains    We Care About Your Health    timeout=${TIMEOUT}
    Page Should Contain Element    id=btn-make-appointment
    Element Should Be Visible    id=btn-make-appointment

*** Keywords ***
Open Browser To CURA Healthcare
    [Documentation]    Opens the browser and navigates to CURA Healthcare with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Close Browser CURA
    [Documentation]    Closes the current browser instance
    Close Browser
```
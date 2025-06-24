 
I'll create a Robot Framework script to reproduce and validate the issue with the CURA Healthcare website based on the Jira ticket information provided.

```
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To CURA Website
Test Teardown     Close Browser Session

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${TIMEOUT}        30s
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify CURA Website Loading
    [Documentation]    Verify that CURA Healthcare website loads successfully
    Wait Until Page Contains Element    xpath=//a[@id='menu-toggle']    timeout=${TIMEOUT}
    Page Should Contain Element    xpath=//h1[contains(text(), 'CURA Healthcare Service')]
    Page Should Contain Element    xpath=//a[@id='btn-make-appointment']
    Capture Page Screenshot    cura_website_loaded.png

*** Keywords ***
Open Browser To CURA Website
    [Documentation]    Opens the browser and navigates to CURA Healthcare site with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Set Selenium Implicit Wait    ${TIMEOUT}

Close Browser Session
    [Documentation]    Closes the current browser instance
    Capture Page Screenshot    final_state.png
    Close Browser
```
 Based on the Jira ticket information, I'll create a Robot Framework script to reproduce the login issue in the UAT environment.

```robotframework
*** Settings ***
Library    SeleniumLibrary
Documentation    Test script to reproduce the login failure issue with username "John Doe"

*** Variables ***
${URL}              https://katalon-demo-cura.herokuapp.com/
${BROWSER}          chrome
${CHROME_OPTIONS}   add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")
${USERNAME}         John Doe
${PASSWORD}         ThisIsNotAPassword
${LOGIN_BUTTON}     id=btn-login
${MENU_TOGGLE}      xpath=//a[@id='menu-toggle']
${LOGIN_LINK}       xpath=//a[@id='login']
${USERNAME_FIELD}   id=txt-username
${PASSWORD_FIELD}   id=txt-password
${ERROR_MESSAGE}    xpath=//p[@class='lead text-danger']

*** Test Cases ***
Verify Login Failure
    [Documentation]    Verify that login fails with username "John Doe" and password "ThisIsNotAPassword"
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Click Element    ${MENU_TOGGLE}
    Wait Until Element Is Visible    ${LOGIN_LINK}
    Click Element    ${LOGIN_LINK}
    
    # Verify login page is loaded
    Wait Until Element Is Visible    ${USERNAME_FIELD}
    Wait Until Element Is Visible    ${PASSWORD_FIELD}
    
    # Attempt login
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Password    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    
    # Verify login fails
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    Element Should Be Visible    ${ERROR_MESSAGE}
    Element Should Contain    ${ERROR_MESSAGE}    Login failed
    
    # Capture screenshot for evidence
    Capture Page Screenshot    login_failure.png
    
    Close Browser

*** Keywords ***
Maximize Browser Window
    ${window size}=    Evaluate    {'width': 1920, 'height': 1080}
    Set Window Size    ${window size}[width]    ${window size}[height]
```

This script:
1. Opens the demo application URL in Chrome headless mode
2. Navigates to the login page
3. Enters the specified credentials (John Doe/ThisIsNotAPassword)
4. Attempts to login
5. Verifies that the login fails by checking for an error message
6. Takes a screenshot as evidence of the issue
7. Closes the browser

The script includes the necessary headless Chrome configuration to run on AWS EC2 Linux environments.
 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser Session

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${MENU_TOGGLE}    id=menu-toggle
${LOGIN_LINK}     xpath=//a[@href='profile.php#login']
${USERNAME_FIELD}    id=txt-username
${PASSWORD_FIELD}    id=txt-password
${LOGIN_BUTTON}    id=btn-login

*** Test Cases ***
Reproduce Login Issue
    [Documentation]    Reproduces the reported login issue
    Navigate To Login Page
    Enter Username And Password    ${USERNAME}    ${PASSWORD}
    Click Login Button
    Verify Login Fails
    Capture Page Screenshot    login-failure.png

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Opens the browser and navigates to the application homepage
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Page Contains Element    ${MENU_TOGGLE}    timeout=10s

Navigate To Login Page
    [Documentation]    Navigates to the login page
    Click Element    ${MENU_TOGGLE}
    Wait Until Element Is Visible    ${LOGIN_LINK}    timeout=10s
    Click Element    ${LOGIN_LINK}
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    
Enter Username And Password
    [Documentation]    Enters username and password
    [Arguments]    ${user}    ${pass}
    Input Text    ${USERNAME_FIELD}    ${user}
    Input Text    ${PASSWORD_FIELD}    ${pass}

Click Login Button
    [Documentation]    Clicks the login button
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s

Verify Login Fails
    [Documentation]    Verifies login failure message is displayed
    Page Should Contain    Login failed
    Page Should Contain Element    xpath=//p[contains(text(),'Login failed')]

Close Browser Session
    [Documentation]    Closes the current browser instance
    Capture Page Screenshot    final-state.png
    Close Browser
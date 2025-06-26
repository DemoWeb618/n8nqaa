 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser To Application
Test Teardown     Close Browser Session
Library           DateTime

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       NSSSS.sk
${SYSTEM_DATE}    2025-06-26
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Account Information Retrieval
    [Documentation]    Verify that the system is able to retrieve account information
    Navigate To Login Page
    Input Username And Password    ${USERNAME}    ThisIsNotAPassword
    Click Login Button
    Verify Error Retrieving Account Information

*** Keywords ***
Open Browser To Application
    [Documentation]    Opens the browser and navigates to the application with specified options
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Element Is Visible    id=btn-make-appointment    timeout=10s
    Page Should Contain    CURA Healthcare Service
    Page Should Contain    We Care About Your Health

Navigate To Login Page
    [Documentation]    Navigate from the home page to the login page
    Click Element    id=btn-make-appointment
    Wait Until Element Is Visible    id=txt-username    timeout=10s

Input Username And Password
    [Arguments]    ${username}    ${password}
    [Documentation]    Enter the username and password
    Input Text    id=txt-username    ${username}
    Input Text    id=txt-password    ${password}

Click Login Button
    [Documentation]    Click the login button to attempt authentication
    Click Element    id=btn-login
    Sleep    2s

Verify Error Retrieving Account Information
    [Documentation]    Verify that an error message is displayed indicating account information cannot be retrieved
    Page Should Contain Element    css=.text-danger
    Page Should Contain    Login failed! Please ensure the username and password are valid.

Close Browser Session
    [Documentation]    Closes the current browser instance
    Close Browser
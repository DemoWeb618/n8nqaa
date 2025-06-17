 *** Settings ***
Library    SeleniumLibrary
Documentation    Test to reproduce login issue in UAT system - SCRUM-38

*** Variables ***
${URL}    https://katalon-demo-cura.herokuapp.com/
${USERNAME}    John Doe
${PASSWORD}    ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")

*** Test Cases ***
Verify Login Failure Issue
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    Maximize Browser Window
    
    # Navigate to login page
    Click Element    xpath=//a[@id='btn-make-appointment']
    
    # Wait for login form to load
    Wait Until Element Is Visible    id=txt-username    timeout=10s
    
    # Enter credentials
    Input Text    id=txt-username    ${USERNAME}
    Input Text    id=txt-password    ${PASSWORD}
    
    # Click login button
    Click Button    id=btn-login
    
    # Verify login fails as reported in the issue
    Wait Until Element Is Visible    xpath=//p[contains(text(),'Login failed')]    timeout=5s
    
    # Take screenshot for evidence
    Capture Page Screenshot    login-failure-evidence.png
    
    Close Browser
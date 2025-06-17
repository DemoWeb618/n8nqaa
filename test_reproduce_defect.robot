 *** Settings ***
Library    SeleniumLibrary
Documentation    Test to reproduce login issue in UAT system - SCRUM-38

*** Variables ***
${URL}    https://uat-environment-url.com    # Replace with actual UAT URL
${USERNAME}    John Doe
${PASSWORD}    ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")

*** Test Cases ***
Verify Login Failure Issue
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    Maximize Browser Window
    
    # Wait for login page to load
    Wait Until Page Contains Element    id:login-form    timeout=10s
    
    # Enter credentials
    Input Text    id:username    ${USERNAME}
    Input Text    id:password    ${PASSWORD}
    
    # Click login button
    Click Button    id:login-button
    
    # Verify login fails as reported in the issue
    Wait Until Page Contains    Invalid credentials    timeout=5s
    
    # Take screenshot for evidence
    Capture Page Screenshot    login-failure-evidence.png
    
    Close Browser
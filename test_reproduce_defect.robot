 
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")
${INVALID_USERNAME}    John Doe
${INVALID_PASSWORD}    ThisIsNotAPassword
${VALID_USERNAME}    John Doe
${VALID_PASSWORD}    ThisIsAPassword
${LOGIN_BUTTON}    id=btn-login
${MENU_TOGGLE}    id=menu-toggle
${LOGIN_LINK}    xpath=//a[contains(text(),'Login')]
${USERNAME_FIELD}    id=txt-username
${PASSWORD_FIELD}    id=txt-password
${APPOINTMENT_HEADER}    xpath=//h2[contains(text(),'Make Appointment')]

*** Test Cases ***
Verify Login Failure With Invalid Credentials
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    Click Element    ${MENU_TOGGLE}
    Wait Until Element Is Visible    ${LOGIN_LINK}
    Click Element    ${LOGIN_LINK}
    Wait Until Element Is Visible    ${USERNAME_FIELD}
    Input Text    ${USERNAME_FIELD}    ${INVALID_USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Page Should Contain Element    xpath=//p[contains(text(),'Login failed')]
    Capture Page Screenshot    login_failure.png
    Close Browser

Verify Login Success With Valid Credentials
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    Click Element    ${MENU_TOGGLE}
    Wait Until Element Is Visible    ${LOGIN_LINK}
    Click Element    ${LOGIN_LINK}
    Wait Until Element Is Visible    ${USERNAME_FIELD}
    Input Text    ${USERNAME_FIELD}    John Doe
    Input Text    ${PASSWORD_FIELD}    ThisIsAPassword
    Click Button    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${APPOINTMENT_HEADER}
    Page Should Contain Element    ${APPOINTMENT_HEADER}
    Capture Page Screenshot    login_success.png
    Close Browser
 *** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://katalon-demo-cura.herokuapp.com/
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")
${USERNAME}    John Doe
${PASSWORD}    ThisIsNotAPassword
${LOGIN_BUTTON}    id=btn-login
${MENU_TOGGLE}    id=menu-toggle
${LOGIN_LINK}    xpath=//a[contains(text(),'Login')]
${USERNAME_FIELD}    id=txt-username
${PASSWORD_FIELD}    id=txt-password

*** Test Cases ***
Verify Login Failure
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    Click Element    ${MENU_TOGGLE}
    Wait Until Element Is Visible    ${LOGIN_LINK}
    Click Element    ${LOGIN_LINK}
    Wait Until Element Is Visible    ${USERNAME_FIELD}
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Page Should Contain Element    xpath=//p[contains(text(),'Login failed')]
    Capture Page Screenshot    login_failure.png
    Close Browser
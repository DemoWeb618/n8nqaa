 
*** Settings ***
Library           SeleniumLibrary
Test Setup        Open Browser And Login
Test Teardown     Close Browser

*** Variables ***
${BROWSER}        chrome
${URL}            https://katalon-demo-cura.herokuapp.com/
${USERNAME}       John Doe
${PASSWORD}       ThisIsNotAPassword
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-save-password-bubble");add_argument("--disable-autofill-keyboard-accessory-view");add_argument("--disable-password-generation");add_argument("--disable-autofill")

*** Test Cases ***
Verify Language Translation Issue In Response Messages
    [Documentation]    Verify that HTML tags are visible in translated messages
    Make Appointment    
    Verify Response Message Format

Successful Login And Appointment
    [Documentation]    Valid case - Verify user can login and make appointment successfully
    Make Appointment
    Verify Appointment Success

*** Keywords ***
Open Browser And Login
    [Documentation]    Opens the browser and logs in to the application
    Open Browser    ${URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Maximize Browser Window
    Wait Until Element Is Visible    id=menu-toggle    timeout=10s
    Click Element    id=menu-toggle
    Wait Until Element Is Visible    xpath=//a[@href='profile.php#login']    timeout=5s
    Click Element    xpath=//a[@href='profile.php#login']
    Wait Until Element Is Visible    id=txt-username    timeout=5s
    Input Text    id=txt-username    ${USERNAME}
    Input Text    id=txt-password    ${PASSWORD}
    Click Button    id=btn-login
    Wait Until Element Is Visible    id=appointment    timeout=10s

Make Appointment
    [Documentation]    Creates a new appointment
    Click Element    id=btn-make-appointment
    Wait Until Element Is Visible    id=combo_facility    timeout=5s
    Select From List By Label    id=combo_facility    Tokyo CURA Healthcare Center
    Select Checkbox    id=chk_hospotal_readmission
    Click Element    id=radio_program_medicare
    Input Text    id=txt_visit_date    30/12/2023
    Input Text    id=txt_comment    This is a test appointment with language translation check. <br> ข้อความภาษาไทย <em>emphasized text</em> <a href="test.html">link</a>
    Click Button    id=btn-book-appointment
    Wait Until Element Is Visible    id=summary    timeout=10s

Verify Response Message Format
    [Documentation]    Checks if HTML tags are improperly displayed in the message
    Page Should Contain Element    id=summary
    Element Should Contain    id=comment    This is a test appointment with language translation check. <br> ข้อความภาษาไทย <em>emphasized text</em> <a href="test.html">link</a>
    Capture Page Screenshot    language_translation_issue.png
    # Verify the specific HTML tags are visible in the text (the defect)
    Page Should Contain    <br>
    Page Should Contain    <em>
    Page Should Contain    <a href=
    
Verify Appointment Success
    [Documentation]    Validates that appointment was created successfully (valid case)
    Page Should Contain Element    id=summary
    Element Should Contain    xpath=//div[@class='col-xs-12 text-center']/h2    Appointment Confirmation
    Page Should Contain Element    id=facility
    Page Should Contain Element    id=hospital_readmission
    Page Should Contain Element    id=program
    Page Should Contain Element    id=visit_date
    Page Should Contain Element    id=comment
    Capture Page Screenshot    successful_appointment.png
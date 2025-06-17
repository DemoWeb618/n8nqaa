*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.google.com
${CHROME_OPTIONS}    add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage")

*** Test Cases ***
Open Google And Close Browser
    Open Browser    ${URL}    chrome    options=${CHROME_OPTIONS}
    Sleep    3s
    Close Browser
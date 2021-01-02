*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         www.sheypoor.com
${BROWSER}        firefox
${DELAY}          1
${VALID USER}
${VALID PASSWORD}
${HOMEPAGE URL}   https://${SERVER}/

*** Keywords ***
Open Browser To Home Page
    Open Browser    ${HOMEPAGE URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Home Page Should Be Open

Home Page Should Be Open
    Title Should Be    شیپور - نیازمندیهای رایگان خرید و فروش، استخدام و خدمات
    Page Should Contain     ثبت آگهی رایگان

*** Settings ***
Documentation                                    A test suite with a single test for testing Install and Run Sheypoor App.
Library                                          AppiumLibrary
Library                                          BuiltIn
Test Setup                                       Set Log Level                  TRACE
Test Teardown                                    close all applications

*** Variables ***
${REMOTE_URL}                                    http://127.0.0.1:4723/wd/hub
${PLATFORM_NAME}                                 Android
${PLATFORM_VERSION}                              8.1
${DEVICE_NAME}                                   emulator-5554
${ACTIVITY_NAME}                                 com.android.vending.AssetBrowserActivity
${PACKAGE_NAME}                                  com.android.vending
${App_Name}                                      شیپور
${App_Package}                                   com.sheypoor.mobile
${App_Aativity}                                  com.sheypoor.mobile.MainActivity

#locators
${Search_Bar}                                    android=UiSelector().resourceId("com.android.vending:id/0_resource_name_obfuscated").text("Search for apps & games")
${App_Status}                                    class=android.widget.Button

*** Test Cases ***
Install Sheypoor On The Mobile
    Open GooglePlay
    Make Sure The Page Is Fully Loaded
    Serach Desired App
    Install App
    Make Sure The App Is Installed Successfully
    Open App

*** Keywords ***
Open GooglePlay
    open application                              ${REMOTE_URL}
    ...                                           platformName=${PLATFORM_NAME}
    ...                                           platformVersion=${PLATFORM_VERSION}
    ...                                           deviceName=${DEVICE_NAME}
    ...                                           automationName=UiAutomator2
    ...                                           newCommandTimeout=2500
    ...                                           appActivity=${ACTIVITY_NAME}
    ...                                           appPackage=${PACKAGE_NAME}

Make Sure The Page Is Fully Loaded
    Wait Until Page Contains Element              ${Search_Bar}             timeout=20s

Serach Desired App
    click element                                 ${Search_Bar}
    input text                                    ${Search_Bar}             ${App_Name}
    press keycode                                 66

Install App
    ${Status}                                     get text                  ${App_Status}
    run keyword if                                '${Status}'=='Open'
    ...                                           run keywords
    ...                                           log to console            \nThis program is already installed on the device.\nUninstallation Started......
    ...                                           AND                       Uninstall App
    wait until page contains                      Install                   timeout=30s
    page should contain text                      Install
    click text                                    Install
    log to console                                \nInstallation Started......

Make Sure The App Is Installed Successfully
    wait until page contains                      Open                      timeout=140s
    page should contain text                      Open

Open App
    click element                                 ${App_Status}
    wait until page contains                      انصراف                    timeout=20s
    page should contain text                      انصراف
    close application

Uninstall App
    open application                              ${REMOTE_URL}
    ...                                           platformName=${PLATFORM_NAME}
    ...                                           platformVersion=${PLATFORM_VERSION}
    ...                                           deviceName=${DEVICE_NAME}
    ...                                           automationName=UiAutomator2
    ...                                           newCommandTimeout=2500
    ...                                           appActivity=${App_Aativity}
    ...                                           appPackage=${App_Package}
    remove application                            ${App_Package}
    log to console                                \nUninstallation Finished.
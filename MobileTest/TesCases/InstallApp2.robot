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
${APK_PATH}                                      ${EXECDIR}/APK
${APK_NAME}                                      Sheypoor-PlayStoreDebug.apk


#locators

*** Test Cases ***
Install Sheypoor On The Mobile
    Install Application

*** Keywords ***
Install Application
    open application                              ${REMOTE_URL}
    ...                                           app=${APK_PATH}/${APK_NAME}
    ...                                           platformName=${PLATFORM_NAME}
    ...                                           platformVersion=${PLATFORM_VERSION}
    ...                                           deviceName=${DEVICE_NAME}
    ...                                           automationName=UiAutomator2
    ...                                           newCommandTimeout=2500
    ...                                           fullReset=True


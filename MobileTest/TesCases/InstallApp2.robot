*** Settings ***
Documentation                               A test suite with a single test for testing Install and Run Sheypoor App.
Library                                     AppiumLibrary
Library                                     BuiltIn
Library                                     ${CURDIR}${/}../Lib/Appium_Extended.py
Test Setup                                  Set Log Level               TRACE
#Test Teardown                               close all applications

*** Variables ***
${REMOTE_URL}                               http://127.0.0.1:4723/wd/hub
${PLATFORM_NAME}                            Android
${PLATFORM_VERSION}                         8.1
${DEVICE_NAME}                              emulator-5554
${APK_PATH}                                 ${CURDIR}${/}..\\APK
${APK_NAME}                                 Sheypoor-PlayStoreDebug.apk
${Image_Path}                               ${CURDIR}${/}..\\TestData\\Images

#locators
${Environment}                              android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/fragmentDebugStaging").text("STAGING")
${Cancel}                                   android=UiSelector().resourceId("android:id/button2").text("انصراف")
${New_Ad}                                   android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/postAdFab")
${Categories}                               android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/componentTextViewRoot")
${Categories_Search}                        android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/toolbarRootHint").text("جستجو")
${Category_Name}                            android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/toolbarSearchBarInput")
${Pezho}                                    android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/adapterCategoryTitle").text("وسایل نقلیه")
${Car_Model}                                android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/componentSpinnerRoot")
${Car_Type}                                 accessibility_id=۲۰۶ (تیپ۵)
${Production_Year}                          //android.widget.LinearLayout[@content-desc="سال تولید (چهار رقمی)"]/android.widget.LinearLayout/android.view.ViewGroup[1]/android.widget.EditText
${Kilometer}                                //android.widget.LinearLayout[@content-desc="کیلومتر"]/android.widget.LinearLayout/android.view.ViewGroup[1]/android.widget.EditText
${Color_List}                               //android.widget.LinearLayout[@content-desc="رنگ"]/android.widget.LinearLayout/android.widget.FrameLayout
${Color}                                    accessibility_id=سفید
${Gear_List}                                //android.widget.LinearLayout[@content-desc="گیربکس"]/android.widget.LinearLayout/android.widget.FrameLayout
${Gear_Type}                                accessibility_id=اتوماتیک
${Fuel_List}                                //android.widget.LinearLayout[@content-desc="نوع سوخت"]/android.widget.LinearLayout/android.widget.FrameLayout
${Fuel}                                     accessibility_id=بنزین
${Body_Status_List}                         //android.widget.LinearLayout[@content-desc="وضعیت بدنه"]/android.widget.LinearLayout/android.widget.FrameLayout
${Body_Status}                              accessibility_id=سالم بدون خط و خش
${Title}                                    //android.widget.LinearLayout[@content-desc="عنوان آگهی"]/android.widget.LinearLayout/android.view.ViewGroup[1]/android.widget.EditText
${Description}                              //android.widget.LinearLayout[@content-desc="توضیحات"]/android.widget.LinearLayout/android.view.ViewGroup/android.widget.EditText
${Price}                                    //android.widget.LinearLayout[@content-desc="قیمت (تومان)"]/android.widget.LinearLayout/android.view.ViewGroup[1]/android.widget.EditText
${Payment_List}                             //android.widget.LinearLayout[@content-desc="نقدی/اقساطی"]/android.widget.LinearLayout/android.widget.FrameLayout
${Payment}                                  accessibility_id=نقدی
${Location}                                 //android.widget.LinearLayout[@content-desc="موقعیت مکانی"]/android.widget.LinearLayout/android.widget.FrameLayout
${Location_Search}                          android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/toolbarRootBackground")
${Location_Name}                            android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/toolbarSearchBarInput").text("استان، شهر یا محله را وارد کنید")
${District}                                 android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/adapterLocationSuggestionTitle")
${Images_Element}                           android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/postAdAttachImage")
${Image_Type}                               android=UiSelector().text("انتخاب از گالری")
${Permission}                               android=UiSelector().resourceId("com.android.packageinstaller:id/permission_allow_button").text("ALLOW")
${Image_Checkbox}                           android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/postAddGalleryImageCheckBox")
${Confirmation}                             android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/phoneGalleryAdButton")
${Loaded_Listing_Image}                     android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/adapterPostAdCapture")
${Contact_Number}                           //android.widget.LinearLayout[@content-desc="شماره تماس آگهی"]/android.widget.LinearLayout/android.view.ViewGroup[1]/android.widget.EditText
${Submit_Btn}                               android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/fragmentPostAdButton")
${Mobile}                                   android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/numberInput").text("شماره تلفن همراه")
${Next}                                     android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/loginButton").text("ورود یا ثبت نام در شیپور")
${Code}                                     android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/pinCodeInput")
${Verification}                             android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/verifyButton").text("تایید نهایی")

*** Test Cases ***
Install Sheypoor On The Mobile
    Install Application
    Launch Application
    Insert Photo From Listing Images To Device
    Click On The New Ad
    Add Images
    Select Car Brand
    Select Car Type
    Input Price
    Select Payment Type
    Input Production Year
    Input Kilometer
    Select Car Color
    Select Gear Type
    Select Fuel Type
    Select Body Status
    Input Title And Description
    Select Location
    Input Contact Number
    Submit Post Listing
    Enter Mobile Number And Verification Code

*** Keywords ***
Install Application
    open application                         ${REMOTE_URL}
    ...                                      app=${APK_PATH}\\${APK_NAME}
    ...                                      platformName=${PLATFORM_NAME}
    ...                                      platformVersion=${PLATFORM_VERSION}
    ...                                      deviceName=${DEVICE_NAME}
    ...                                      automationName=UiAutomator2
    ...                                      newCommandTimeout=2500
#    ...                                      fullReset=True

Launch Application
    Click By Selector                        ${Environment}
    Click By Selector                        ${Cancel}

Click On The New Ad
    Click By Selector                        ${New_Ad}
    Wait Until Page Contains Element         ${Images_Element}              timeout=5s
    Page Should Contain Element              ${Categories}                  timeout=5s

Add Images
    Click By Selector                       ${Images_Element}
    Click By Selector                       ${Image_Type}
    Click By Selector                       ${Permission}
    Click By Selector                       ${Image_Checkbox}
    Wait Until Page Contains Element        ${Confirmation}                 timeout=5s
    Page Should Contain Text                 انتخاب 1 از 8 عکس
    click by selector                        ${Confirmation}
    sleep       10s
    Page Should Contain Element              ${Loaded_Listing_Image}

Select Car Brand
    Click By Selector                        ${Categories}
    sleep       10s
    Click By Selector                        ${Categories_Search}
    Input Text                               ${Category_Name}              پژو
    Click By Selector                        ${Pezho}

Select Car Type
    Click By Selector                        ${Car_Model}
    Click By Selector                        ${Car_Type}

Input Price
    ${Temp}                                  Evaluate                      random.randint(100000000,300000000)
    Scroll Down If Element Not Found
    Click By Selector                        ${Price}
    Input Text                               ${Price}                      ${Temp}

Select Payment Type
    Click By Selector                        ${Payment_List}
    Click By Selector                        ${Payment}

Input Production Year
    ${Year}                                  Evaluate                      random.randint(1300,1499)
    Set Test Variable                        ${Year}
    Scroll Down If Element Not Found
    Click By Selector                        ${Production_Year}
    Input Text                               ${Production_Year}            ${Year}

Input Kilometer
    ${Temp}                                  Evaluate                      random.randint(0,200000)
    Scroll Down If Element Not Found
    Input Text                               ${Kilometer}                  ${Temp}

Select Car Color
    Click By Selector                        ${Color_List}
    Click By Selector                        ${Color}

Select Gear Type
    Scroll Down If Element Not Found
    Click By Selector                        ${Gear_List}
    Click By Selector                        ${Gear_Type}

Select Fuel Type
    Scroll Down If Element Not Found
    Click By Selector                        ${Fuel_List}
    Click By Selector                        ${Fuel}

Select Body Status
    Scroll Down If Element Not Found
    Click By Selector                        ${Body_Status_List}
    Click By Selector                        ${Body_Status}

Input Title And Description
    Scroll Down If Element Not Found
    Click By Selector                        ${Title}
    Input Text                               ${Title}                      پژو 206مدل${Year}
    Click By Selector                        ${Description}
    Input Text                               ${Description}                پژو 206 مدل${Year} کاملا سالم می باشد

Select Location
    Scroll Down If Element Not Found
    Click By Selector                        ${Location}
    click by selector                        ${Location_Search}
    Input Text                               ${Location_Name}               آرژانتین
    Click By Selector                        ${District}

Input Contact Number
    Click By Selector                       ${Contact_Number}
    Input Text                              ${Contact_Number}               09371008676

Submit Post Listing
    Scroll Down If Element Not Found
    Click By Selector                        ${Submit_Btn}

Enter Mobile Number And Verification Code
    Wait Until Page Contains                 لطفاً برای ثبت نام یا ورود، شماره تلفن همراه خود را وارد نمایید.                     timeout=10s
    Input Text                               ${Mobile}                      09001111111
    Click By Selector                        ${Next}
    Wait Until Page Contains                 کد چهار رقمی پیامک شده به 09001111111 را وارد کنید.
    Input Text                               ${Code}                        1111
    Click By Selector                        ${Verification}

Click By Selector
    [Arguments]                              ${Selector}
    Wait Until Keyword Succeeds   3x  3s     Click Element                  ${Selector}
    Sleep  300ms

Scroll Down If Element Not Found
    swipe   15    600    15    200


Insert Photo From Listing Images To Device
    Push File To Device   /mnt/sdcard/Pictures/1.jpg   source_path=${Image_Path}//1.jpg
    adb shell              am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file:///mnt/sdcard/Pictures/1.jpg




*** Settings ***
Documentation                               A test suite with a single test for testing Install and Run Sheypoor App.
Library                                     AppiumLibrary
Library                                     BuiltIn
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
${Contact_Number}                           ///android.widget.LinearLayout[@content-desc="شماره تماس آگهی"]/android.widget.LinearLayout/android.view.ViewGroup[1]/android.widget.EditText
${Submit_Btn}                               android=UiSelector().resourceId("com.sheypoor.mobile.debug:id/fragmentPostAdButton").text("ثبت آگهی")
${Mobile}
${Next}
${Code}
${Verification}

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
#    Validate Image Is Upload
    Submit Post Listing
#    Enter Mobile Number And Verification Code

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
    Scroll Down If Element Not Found
    Click By Selector                       ${Contact_Number}
    Input Text                              ${Contact_Number}               09371008676

Validate Image Is Upload
    FOR    ${INDEX}                          IN RANGE    0   5
      ${isUploading}                         Execute Javascript             return window.bee('.fine-uploader .qq-upload-spinner-selector, .fine-uploader .qq-upload-retry-selector').is(':visible')
      Exit For Loop If                       not ${isUploading}
      Sleep                                  2s
    END
    Run Keyword If                           ${isUploading}    Fail         image can not be uploaded
    Page Should Not Contain                  لطفا این قسمت را تکمیل کنید
    Page Should Not Contain                  عکس ها در حال بارگذاری هستند
    Page Should Not Contain                  این فیلد اجباریست

Submit Post Listing
    Wait Until Element Is Enabled            ${Submit_Btn}                  timeout=5s
    Click Button                             ${Submit_Btn}

Enter Mobile Number And Verification Code
    Wait Until Page Contains                 اطلاعات شما                     timeout=10s
    Input Text                               ${Mobile}                      09001111111
    Click Button                             ${Next}
    Wait Until Page Contains                 کد چهار رقمی پیامک شده به 09001111111 را وارد کنید.
    Input Text                               ${Code}                        1111
    Click Button                             ${Verification}
    Page Should Contain                      کد تایید صحیح نمی باشد

Click By Selector
    [Arguments]                              ${Selector}
    Wait Until Keyword Succeeds   3x  3s     Click Element                  ${Selector}
    Sleep  300ms

Scroll Down If Element Not Found
    swipe   15    600    15    200


Insert Photo From Listing Images To Device
    push file           mnt/sdcard/Pictures/1.jpg     ${Image_Path}\\1.jpg
    adb shell           am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file:///mnt/sdcard/Pictures/1.jpg



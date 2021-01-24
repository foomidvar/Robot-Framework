*** Settings ***
Documentation            A test suite with a single test for Post new advertising.
Resource                 ../Resources/resource.robot
Library                  OperatingSystem
Library                  SeleniumLibrary
Library                  ExcelLibrary
Library                  BuiltIn
Library                  Collections
Library                  String
Test Setup               Read Data From Excel File
Test Teardown            Close Browser

*** Variables ***
${Excel_Path}            ${EXECDIR}/TestData
${Image_Path}            ${EXECDIR}/TestData/Images
${Excel_Name}            TestData.xlsx
${Excel_Sheet_Name}      Sheet1
#locators
${New_Ad}                css:[class="button small icon-plus square-round"]
${Categories}            css:[data-popup="popup-categories"]
${Categories_Search}     css:[placeholder="جستجو..."]
${Vasayel_Naghlie}       css:[class="link colored t-cat-43626 icon-category-43626"]
${Khodro}                css:[class="link colored t-cat-43627"]
${Pezho}                 css:[class="link colored t-cat-43973"]
${Car_Model}             css:[data-popup="item-form-a68142"]
${Car_Type}              class:icon-attr-440656
${Production_Year}       id:a68101
${Kilometer}             id:a68102
${Color_List}            css:[data-popup="item-form-a69130"]
${Color}                 class:icon-attr-445243
${Gear_List}             css:[data-popup="item-form-a69140"]
${Gear_Type}             class:icon-attr-445308
${Body_Status_List}      css:[data-popup="item-form-a69160"]
${Body_Status}           class:icon-attr-445317
${Title}                 id:item-form-title
${Description}           id:item-form-description
${Price}                 id=item-form-price
${Location}              css:[data-popup="popup-locations"]
${Location_Search}       //input[starts-with(@placeholder,'جستجو در')]
${Ostan}                 class:t-province-8
${City}                  class:t-city-301
${District}              class:t-district-933
${Images_Element}        name:qqfile
${Submit_Btn}            //form/p/button[contains(@type,'submit') and contains(.,'ثبت آگهی')]
${Mobile}                id:username
${Next}                  //button[contains(@type,'submit') and contains(.,'بعدی')]
${Code}                  id:code
${Verification}          //button[contains(@type,'submit') and contains(.,'تائید و ثبت نهایی آگهی')]

*** Test Cases ***
Regiter new advertising
    Open Browser To Home Page
    Go To New Listing Page
    Add Images
    Select Car Brand
    Select Car Colour
    Input Production Year
    Input Kilometer
    Select Gear Type
    Select Body Status
    Input Title And Description
    Input Price
    Select Location
    Validate Image Is Upload
    Submit Post Listing
    Enter Mobile Number And Verification Code

*** Keywords ***
Go To New Listing Page
    Click Link                               ${New_Ad}
    Wait Until Page Contains Element         ${Images_Element}              timeout=5s
    Page Should Contain Element              ${Categories}                  timeout=5s

Select Car Brand
    Click Element                            ${Categories}
    Input Text                               ${Categories_Search}           ${RowData}[0]
    Click Element                            ${Vasayel_Naghlie}
    Input Text                               ${Categories_Search}           ${RowData}[1]
    Click Element                            ${Khodro}
    Input Text                               ${Categories_Search}           ${RowData}[2]
    Click Element                            ${Pezho}

Select Car Colour
    Click By Css Selector                    ${Color_List}
    Click Element                            ${Color}

Select Car Type
    Click By Css Selector                    ${Car_Model}
    Click Element                            ${Car_Type}

Input Production Year
    ${Year}                                  Evaluate                      random.randint(1300,1499)
    Set Test Variable                        ${Year}
    Input Text                               ${Production_Year}            ${Year}

Input Kilometer
    ${Temp2}                                 Evaluate                      random.randint(0,200000)
    Input Text                               ${Kilometer}                  ${Temp2}

Select Gear Type
    Click By Css Selector                    ${Gear_List}
    Click Element                            ${Gear_Type}

Select Body Status
    Click By Css Selector                    ${Body_Status_List}
    Click Element                            ${Body_Status}

Input Title And Description
    Input Text                               ${Title}                      ${RowData[2]}${RowData[3]}مدل${Year}
    Input Text                               ${Description}                ${RowData[2]}${RowData[3]}مدل${Year}

Input Price
    ${Temp}                                  Evaluate                      random.randint(100000000,300000000)
    Input Text                               ${Price}                      ${Temp}

Select Location
    Click Element                            ${Location}
    Input Text                               ${Location_Search}            ${RowData[4]}
    Click Element                            ${Ostan}
    Input Text                               ${Location_Search}            ${RowData[5]}
    Click Element                            ${City}
    Input Text                               ${Location_Search}            ${RowData[6]}
    Click Element                            ${District}

Add Images
    @{my_file_list}                          OperatingSystem.List Files In Directory           ${Image_Path}
    FOR    ${file}    IN                     @{my_file_list}
        ${result}                            Choose File                  ${Images_Element}    ${Image_Path}/${file}
    END

Validate Image Is Upload
    FOR    ${INDEX}                          IN RANGE    0   5
      ${isUploading}                         Execute Javascript           return window.bee('.fine-uploader .qq-upload-spinner-selector, .fine-uploader .qq-upload-retry-selector').is(':visible')
      Exit For Loop If                       not ${isUploading}
      Sleep                                  2s
    END
    Run Keyword If                           ${isUploading}    Fail       image can not be uploaded
    Page Should Not Contain                  لطفا این قسمت را تکمیل کنید
    Page Should Not Contain                  عکس ها در حال بارگذاری هستند
    Page Should Not Contain                  این فیلد اجباریست

Submit Post Listing
    Wait Until Element Is Enabled            ${Submit_Btn}                timeout=5s
    Click Button                             ${Submit_Btn}

Enter Mobile Number And Verification Code
    Wait Until Page Contains                 اطلاعات شما                   timeout=10s
    Input Text                               ${Mobile}                    09001111111
    Click Button                             ${Next}
    Wait Until Page Contains                 کد چهار رقمی پیامک شده به 09001111111 را وارد کنید.
    Input Text                               ${Code}                       1111
    Click Button                             ${Verification}
    Page Should Contain                      کد تایید صحیح نمی باشد

Read Data From Excel File
    open excel document                      filename=${Excel_Path}/${Excel_Name}                  doc_id=docid
    @{RowData}                               read excel row               row_num=2                max_num=7          sheet_name=${Excel_Sheet_Name}
    Set Test Variable                        @{RowData}

Click By Css Selector
    [Arguments]                              ${Css_Selector}
    Wait Until Keyword Succeeds   3x  3s     Click Element        ${Css_Selector}
    Sleep  300ms

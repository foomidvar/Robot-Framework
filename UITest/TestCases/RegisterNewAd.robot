*** Settings ***
Documentation           A test suite with a single test for registering new advertising.
Resource                ../Resources/resource.robot
Library                 OperatingSystem
Library                 SeleniumLibrary
Library                 ExcelLibrary
Library                 BuiltIn
Library                 Collections
Library                 String
Test Teardown           Close Browser
Library                 Return_Categories_SubCategories_Info

*** Variables ***
${Excel_Path}           ../TestData
${Image_Path}           ../TestData/Images
${Excel_Name}           TestData.xlsx
${Excel_Sheet_Name}     Sheet1

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
${Images}                name:qqfile
${Register}              //form/p/button[contains(@type,'submit') and contains(.,'ثبت آگهی')]
${Mobile}                id:username
${Next}                  //button[contains(@type,'submit') and contains(.,'بعدی')]
${Code}                  id:code
${Verification}          //button[contains(@type,'submit') and contains(.,'تائید و ثبت نهایی آگهی')]

*** Test Cases ***
Regiter new advertising
    Open Browser To Home Page
    Click Link             ${New_Ad}
    Wait Until Page Contains Element                  ${Categories}           timeout=5s
    Click Element          ${Categories}
    Data Entry
    Add Images
    Enter Mobile Number And Verification Code

*** Keywords ***
Data Entry
    Read Data From Excel File
    ${1st_Category}         set variable              ${RowData}[0]
    Input Text              ${Categories_Search}      ${1st_Category}
    Click Element           ${Vasayel_Naghlie}

    ${2nd_Category}         set variable              ${RowData}[1]
    Input Text              ${Categories_Search}      ${2nd_Category}
    Click Element           ${Khodro}

    ${3rd_Category}         set variable              ${RowData}[2]
    Input Text              ${Categories_Search}      ${3rd_Category}
    Click Element           ${Pezho}

    Wait Until Element Contains                       ${Color_List}        انتخاب کنید
    Click Element           ${Car_Model}
    Wait Until Element Contains                       ${Car_Type}          ۲۰۶ (تیپ۵)
    Page Should Contain Element                       ${Car_Type}
    Click Element           ${Car_Type}

    ${Temp1}                 Evaluate                  random.randint(1300,1499)
    Input Text              ${Production_Year}        ${Temp1}

    ${Temp2}                 Evaluate                  random.randint(0,200000)
    Input Text              ${Kilometer}              ${Temp2}

    Wait Until Element Contains                       ${Color_List}         انتخاب کنید
    Click Element           ${Color_List}
    Wait Until Element Contains                       ${Color}              سفید
    Page Should Contain Element                       ${Color}
    Click Element           ${Color}
    sleep  2s

    Wait Until Element Contains                       ${Gear_List}          انتخاب کنید
    Click Element           ${Gear_List}
    Wait Until Element Contains                       ${Gear_Type}          دنده‌ای
    Page Should Contain Element                       ${Gear_Type}
    Click Element           ${Gear_Type}
    sleep  2s

    Wait Until Element Contains                       ${Body_Status_List}    انتخاب کنید
    Click Element           ${Body_Status_List}
    Wait Until Element Contains                       ${Body_Status}          سالم بدون خط و خش
    Page Should Contain Element                       ${Body_Status}
    Click Element           ${Body_Status}

    Input Text              ${Title}                  ${3rd_Category}${RowData[3]}مدل${Temp1}
    Input Text              ${Description}            ${3rd_Category}${RowData[3]}مدل${Temp1}

    ${Temp}                 Evaluate                  random.randint(100000000,300000000)
    Input Text              ${Price}                  ${Temp}

    Click Element           ${Location}
    ${Province}             Set Variable              ${RowData[4]}
    Input Text              ${Location_Search}        ${Province}
    Click Element           ${Ostan}

    ${County}               Set Variable              ${RowData[5]}
    Input Text              ${Location_Search}        ${County}
    Click Element           ${City}

    ${Region}               Set Variable              ${RowData[6]}
    Input Text              ${Location_Search}        ${Region}
    Click Element           ${District}

Add Images
    @{my_file_list}=        OperatingSystem.List Files In Directory    ${Image_Path}
    FOR    ${file}    IN    @{my_file_list}
        ${result}=          Choose File    ${Images}    ${CURDIR}${/}..\\TestData\\Images\\${file}
    END

    Wait Until Page Does Not Contain                  عکس ها در حال بارگذاری هستند...       timeout=100S
    Wait Until Element Is Enabled                       ${Register}
    Click Button            ${Register}

Enter Mobile Number And Verification Code
    Wait Until Page Contains    اطلاعات شما
    Input Text              ${Mobile}                 09001111111
    Click Button            ${Next}

    Wait Until Page Contains    کد چهار رقمی پیامک شده به 09001111111 را وارد کنید.
    Input Text              ${Code}                     1111
    Click Button            ${Verification}

    Page Should Contain    کد تایید صحیح نمی باشد

Read Data From Excel File
    open excel document     filename=${Excel_Path}/${Excel_Name}  doc_id=docid
    @{RowData} =            read excel row     row_num=2    max_num=7       sheet_name=${Excel_Sheet_Name}
    set test variable       @{RowData}

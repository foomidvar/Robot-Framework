*** Settings ***
Documentation           A test suite with a single test for registering new advertising.
Resource                ../Resources/resource.robot
Library                 OperatingSystem
Library                 SeleniumLibrary
Library                 ExcelLibrary
Library                 BuiltIn
Library                 Collections
Library                 String
Library                 ImageHorizonLibrary
Test Teardown           Close Browser

*** Variables ***
${Excel_Path}           ../TestData
${Image_Path}           ../TestData/Images
${Excel_Name}           TestData.xlsx
${Excel_Sheet_Name}     Sheet1
@{Row_Data}
${Type}

#locators
${New_Ad}                //*[@id="header" ]//a[@class="button small icon-plus square-round"]
${Categories}            //*[@id="item-form"]//a[@data-popup="popup-categories"]
${Categories_Search}     //*[@id="popup-categories"]//input[@placeholder="جستجو..."]
${Vasayel_Naghlie}       //*[@id="popup-categories"]//span[@class="link colored t-cat-43626 icon-category-43626"]
${Khodro}                //*[@id="popup-categories"]//span[@class="link colored t-cat-43627"]
${Pezho}                 //*[@id="popup-categories"]//span[@class="link colored t-cat-43973"]
${Car_Model}             //a[@data-popup="item-form-a68142"]
${Car_Type}              //*[@id="item-form-a68142"]//span[@class="icon-attr-440656"]
${Production_Year}       //*[@id="a68101"]
${Kilometer}             //*[@id="a68102"]
${Color_List}            //a[@data-popup="item-form-a69130"]
${Color}                 //*[@id="item-form-a69130"]//span[@class="icon-attr-445243"]
${Gear_List}             //a[@data-popup="item-form-a69140"]
${Gear_Type}             //*[@id="item-form-a69140"]//span[@class="icon-attr-445308"]
${Body_Status_List}      //a[@data-popup="item-form-a69160"]
${Body_Status}           //*[@id="item-form-a69160"]//span[@class="icon-attr-445317"]
${Title}                 //*[@id="item-form-title"]
${Description}           //*[@id="item-form-description"]
${Price}                 //*[@id="item-form-price"]
${Location}              //a[@data-popup="popup-locations"]
${Location_Search}       //*[@id="popup-locations"]/div/div[2]/form/p/span/input
${Ostan}                 //*[@id="popup-locations"]//span[@class="t-province-8"]
${City}                  //*[@id="popup-locations"]//span[@class="t-city-301"]
${District}              //*[@id="popup-locations"]//span[@class="t-district-933"]
${Images}                //*[@id="item-form"]/div/div[2]/div/div/div/div/div[2]/input
${Register}              //*[@id="item-form"]/div/div[2]/form/p[2]/button
${Mobile}                //*[@id="username"]
${Code}                  //*[@id="code"]

*** Test Cases ***
Regiter new advertising
    Open Browser To Home Page
    Click Link             ${New_Ad}
    Wait Until Page Contains Element                  ${Categories}           timeout=5s
    Click Element          ${Categories}
    Data Entry

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

    Wait Until Element Contains                       ${Gear_List}          انتخاب کنید
    Click Element           ${Gear_List}
    Wait Until Element Contains                       ${Gear_Type}          دنده‌ای
    Page Should Contain Element                       ${Gear_Type}
    Click Element           ${Gear_Type}

    Wait Until Element Contains                       ${Body_Status_List}    انتخاب کنید
    Click Element           ${Body_Status_List}
    Wait Until Element Contains                       ${Body_Status}          سالم بدون خط و خش
    Page Should Contain Element                       ${Body_Status}
    Click Element           ${Body_Status}

    Input Text              ${Title}                  ${3rd_Category}${Type}مدل${Temp1}
    Input Text              ${Description}            ${3rd_Category}${Type}مدل${Temp1}

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

    Click Element           //*[@id="item-form"]/div/div[2]/div/div/div/div/div[2]
    @{my_file_list}=        OperatingSystem.List Files In Directory    ${Image_Path}
    FOR    ${file}    IN    @{my_file_list}
        ${result}=          Choose File    ${Images}    D:\\Robotframework_Projects\\FirstTry\\TestData\\Images\\${file}
    END

    Wait Until Page Does Not Contain                  عکس ها در حال بارگذاری هستند...       timeout=100S
    Press Combination	      KEY.ALT	key.f4
    Wait Until Element Is Enabled                     ${Register}
    Click Button            ${Register}

    Wait Until Page Contains    اطلاعات شما
    Input Text              ${Mobile}                 09001111111
    Click Button            //*[@id="session"]/div/form/p[5]/button

    Wait Until Page Contains    کد چهار رقمی پیامک شده به 09001111111 را وارد کنید.
    Input Text              ${Code}                     1111
    Click Button            //*[@id="session"]/div/form/p[2]/button

    Page Should Contain    کد تایید صحیح نمی باشد


Read Data From Excel File
    open excel document     filename=${Excel_Path}/${Excel_Name}  doc_id=docid
    @{RowData} =            read excel row     row_num=2    max_num=7       sheet_name=${Excel_Sheet_Name}
    ${1st_Category}         Set Variable              ${RowData[0]}
    ${2nd_Category}         Set Variable              ${RowData[1]}
    ${3rd_Category}         Set Variable              ${RowData[2]}
    ${Type}                 Set Variable              ${RowData[3]}
    ${Province}             Set Variable              ${RowData[4]}
    ${County}               Set Variable              ${RowData[5]}
    ${Region}               Set Variable              ${RowData[6]}
    Log to console          \n1st_Category=${1st_Category}, 2nd_Category=${2nd_Category}, 3rd_Category=${3rd_Category}, Type=${Type}
    Set Test Variable       ${Type}
    set test variable       @{RowData}

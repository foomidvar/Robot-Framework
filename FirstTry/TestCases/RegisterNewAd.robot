*** Settings ***
Documentation     A test suite with a single test for registering new advertising.
Resource          ../Resources/resource.robot
Library           OperatingSystem
Library           SeleniumLibrary
Library           ExcelLibrary
Library           BuiltIn
Library           Collections

#Test Teardown     Close Browser

*** Variables ***
${Excel_Path}         ../TestData
${Excel_Name}         TestData.xlsx
${Excel_Sheet_Name}   Sheet1
@{Row_Data}

#locators
${New_Ad}                xpath://*[@id="header"]/div[2]/div/div/a
${Categories}            xpath://*[@id="item-form"]/div/div[1]/form/p[1]/a
${Categories_Search}     xpath://*[@id="popup-categories"]/div/div[2]/form/p/span/input
${Serach_Result}         xpath://*[@id="popup-categories"]/div/div[2]/div/ul[1]/li/span
${Car_Name}              xpath://*[@id="popup-categories"]/div/div[2]/div/ul/li/span
${Car_Model}             xpath://*[@id="item-form"]/div/div[1]/form/div[1]/p/a
@{Car_Model_List}        xpath://*[@id="item-form-a68142"]/div/ul
@{Payment_Type}          xpath://*[@id="item-form"]/div/div[1]/form/div[2]/label

*** Test Cases ***
Regiter new advertising
  Open Browser To Home Page
  Click Link    ${New_Ad}
  Wait Until Page Contains Element    ${Categories}
  Click Element    ${Categories}
  Data Entry


*** Keywords ***
Data Entry
    Open Excel
    ${1st_Category}   set variable   ${RowData}[0]
    Input Text    ${Categories_Search}   ${1st_Category}
    BuiltIn.Sleep  2s
    Click Element   ${Serach_Result}
    BuiltIn.Sleep  2s

    ${2nd_Category}   set variable   ${RowData}[1]
    Input Text    ${Categories_Search}   ${2nd_Category}
    BuiltIn.Sleep  2s
    Click Element   ${Serach_Result}
    BuiltIn.Sleep  2s

    ${3rd_Category}   set variable   ${RowData}[2]
    Input Text    ${Categories_Search}   ${3rd_Category}
    BuiltIn.Sleep  2s
    Click Element   ${Car_Name}
    BuiltIn.Sleep  2s

    Click Element   ${Car_Model}
    ${Type}   set variable   ${RowData}[3]
    log to console   \nTypeOfCaris:   ${Type}
    Select From List By Value     @{Car_Model_List}    ${Type}

Open Excel
    #[Arguments]   ${Excel_Path}
    open excel document     filename=${Excel_Path}/${Excel_Name}  doc_id=docid
    @{RowData} =  read excel row     row_num=2    max_num=7       sheet_name=${Excel_Sheet_Name}
    ${1st_Category}     Set Variable   ${RowData[0]}
    ${2nd_Category}     Set Variable   ${RowData[1]}
    ${3rd_Category}     Set Variable   ${RowData[2]}
    ${Type}             Set Variable   ${RowData[3]}
    ${Province}         Set Variable   ${RowData[4]}
    ${County}           Set Variable   ${RowData[5]}
    ${Region}           Set Variable   ${RowData[6]}
    Log to console    \n1st_Category=${1st_Category}, 2nd_Category=${2nd_Category}, 3rd_Category=${3rd_Category}, Type=${Type}
    set test variable  @{RowData}
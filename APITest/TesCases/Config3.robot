*** Settings ***
Documentation                                    A test suite with a single test for testing Config API.
Library                                          REST                           ${Host}
Test Setup                                       Set Metadata And Headers

*** Variables ***
${Response_File}                                 ExpectedResponse
${Response_Path}                                 ../Outputs
${Host}                                          https://www.sheypoor.com/api/
${EndPoint}                                      /general/config
${Android}                                       {"X-AGENT-TYPE" : "Android App" , "App-Version" : "5.9.0" , "User-Agent" : "Android/4.4.2 Sheypoor/4.1.5 VersionCode/4010400 Manufacturer/HUAWEI Model/HUAWEI Y625-U32"}
${Desktop_Web}                                   {"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36"}
${Mobile_Site}                                   {"User-Agent" : "Mozilla/5.0 (Linux; U; Android 8.1; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"}

*** Test Cases ***
Check Config Api Settings
    Get Config By API Verion And Validate Response
    Validate Performance Log Value

*** Keywords ***
Get Config By API Verion And Validate Response
    Expect Response Body                         ${Response_Path}/${Response_File}_${version}_${Platform}.json
    Get                                          ${version}${EndPoint}                                headers=${headers}

Validate Performance Log Value
    Boolean                                      response body features performance-log               ${Expected_Performance-log}

Set Headers Per Platform
    ${headers}                                   Set Variable If
    ...                                          '${platform}' == 'Android'                           ${Android}
    ...                                          '${platform}' == 'Desktop_Web'                       ${Desktop_Web}
    ...                                          '${platform}' == 'Mobile_Site'                       ${Mobile_Site}
    Set Test Variable                            ${headers}

Set Performance Log Value
    ${Expected_Performance-log}                   set variable if
    ...                                           '${platform}' == 'Android'                          ${False}
    ...                                           '${platform}' == 'Desktop_Web'                      ${True}
    ...                                           '${platform}' == 'Mobile_Site'                      ${True}
    Set Test Variable                             ${Expected_Performance-log}

Set Metadata And Headers
    Set Log Level                                 TRACE
    Set Tags                                      ${platform}                                          ${version}
    Set Test Message                              ${platform} ${version}                               append=True
    Set Suite Metadata                            platform                                             ${platform}     append=True    top=False
    Set Suite Metadata                            api version                                          ${version}      append=True    top=False
    Set Headers Per Platform
    Set Performance Log Value

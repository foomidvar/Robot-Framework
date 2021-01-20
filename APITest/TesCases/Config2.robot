*** Settings ***
Documentation             A test suite with a single test for testing Config API.
Library                   REST               ${Host}
Library                   BuiltIn
Library                   Collections
Test Setup                Set Log Level      TRACE
Test Teardown

*** Variables ***
${Response_File}          ExpectedResponse
${Response_Path}          ../Outputs
${Host}                   https://www.sheypoor.com/api/
${EndPoint}               /general/config
@{API_Versions}           v5.9.0          v5.8.0          v3.1.5
@{Platforms}              Desktop_Web     Mobile_Site     Android
&{Android}                X-AGENT-TYPE=Android App        App-Version=5.9.0         User-Agent=Android/4.4.2 Sheypoor/4.1.5 VersionCode/4010400 Manufacturer/HUAWEI Model/HUAWEI Y625-U32
&{Desktop_Web}            User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36
&{Mobile_Site}            User-Agent=Mozilla/5.0 (Linux; U; Android 8.1; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30

*** Test Cases ***
Test Different Versions of the CONFIG_API on all Platforms
      Set Headers, Send Request And Validate Response

*** Keywords ***
Set Headers, Send Request And Validate Response
    run keyword if        '${platform}' == 'Android'
    ...     set headers    {"X-AGENT-TYPE" : "Android App" , "App-Version" : "5.9.0" , "User-Agent" : "Android/4.4.2 Sheypoor/4.1.5 VersionCode/4010400 Manufacturer/HUAWEI Model/HUAWEI Y625-U32"}

    run keyword if        '${platform}' == 'Desktop_Web'
    ...     set headers    {"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36"}

    run keyword if        '${platform}' == 'Mobile_Site'
    ...     set headers    {"User-Agent" : "Mozilla/5.0 (Linux; U; Android 8.1; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"}

    Send Request And Validate Response

Send Request And Validate Response
    Expect Response        ${Response_Path}/${Response_File}_${version}_${Platform}.json
    Get                    ${version}${EndPoint}







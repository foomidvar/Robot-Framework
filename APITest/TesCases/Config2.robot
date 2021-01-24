*** Settings ***
Documentation             A test suite with a single test for testing Config API.
Library                   REST               ${Host}
Library                   BuiltIn
Test Setup                Set Log Level      TRACE

*** Variables ***
${Response_File}          ExpectedResponse
${Response_Path}          ../Outputs
${Host}                   https://www.sheypoor.com/api/
${EndPoint}               /general/config
&{Android}                X-AGENT-TYPE=Android App        App-Version=5.9.0         User-Agent=Android/4.4.2 Sheypoor/4.1.5 VersionCode/4010400 Manufacturer/HUAWEI Model/HUAWEI Y625-U32
&{Desktop_Web}            User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36
&{Mobile_Site}            User-Agent=Mozilla/5.0 (Linux; U; Android 8.1; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30

*** Test Cases ***
Test Different Versions of the CONFIG_API on all Platforms
     Set Header Values
     Send Request And Validate Response
     Get Performance-log Value
     Check Performance-log Value

*** Keywords ***
Set Header Values

    ${headers}=     set variable if
    ...     '${platform}' == 'Android'      &{Android}
    ...     '${platform}' == 'Desktop_Web'  &{Desktop_Web}
    ...     '${platform}' == 'Mobile_Site'  &{Mobile_Site}
    set test variable      ${headers}

Send Request And Validate Response
    Expect Response        ${Response_Path}/${Response_File}_${version}_${Platform}.json
    Get                    ${version}${EndPoint}         headers=${headers}

Get Performance-log Value
    ${Response}=                output                   response body
    ${performance-log}=         convert to string        '${Response["features"]["performance-log"]}'
    set test variable      ${performance-log}

Check Performance-log Value
    ${Expected_Performance-log}=     set variable if
    ...     '${platform}' == 'Android'      'False'
    ...     '${platform}' == 'Desktop_Web'  'True'
    ...     '${platform}' == 'Mobile_Site'  'True'

    Should Be Equal     ${performance-log}       ${Expected_Performance-log}
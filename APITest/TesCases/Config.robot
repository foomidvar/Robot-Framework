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
&{Android}                X-AGENT-TYPE=Android App        App-Version=5.9.0
&{Desktop_Web}            User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36
&{Mobile_Site}            User-Agent=Mozilla/5.0 (Linux; U; Android 8.1; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30

*** Test Cases ***
Test Different Versions of the CONFIG_API on all Platforms
      Retrieve Versions,Set Headers, Send Request And Validate Response

*** Keywords ***
Retrieve Versions,Set Headers, Send Request And Validate Response
      Log To Console        \nPlatform${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}State
      FOR   ${version}    IN     @{API_Versions}
      Set Test Variable    ${version}
            Set Headers Value For  Android
            Send Request And Validate Response  Android  ${version}

            Set Headers Value For   Desktop_Web
            Send Request And Validate Response  Desktop_Web  ${version}

            Set Headers Value For  Mobile_Site
            Send Request And Validate Response  Mobile_Site  ${version}
      Continue For Loop
      END

Send Get Request
      Get   ${version}${EndPoint}

Set Headers Value For
      [Arguments]       ${Platform}
      FOR  ${key}   IN    @{${Platform}.keys()}
          ${value}=    Get From Dictionary     ${${Platform}}    ${key}
          Set Headers            {"${key}":"${value}"}
          Set Test Variable        ${Platform}
      END

Send Request And Validate Response
      [Arguments]     ${Platform}   ${version}
#      Output Schema              response      file_path=${Response_Path}/${Response_File}_${version}_${Platform}.json
      Expect Response            ${Response_Path}/${Response_File}_${version}_${Platform}.json
      Send Get Request

      ${Result}=  Run Keyword And Ignore Error    Expect Response      ${Response_Path}/${Response_File}_${version}_${Platform}.json
      Run Keyword If    '${Result[0]}'=='PASS'  Log To Console    \n${Platform}${SPACE}${version}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}"True"
      ...     ELSE      Log To Console    \n${Platform}${SPACE}${version}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}"False"

*** Settings ***
Documentation             A test suite with a single test for testing Config API.
# Resource                  ${EXECDIR}/Variables/ConstantVariables.robot
# Resource                  ${EXECDIR}/Variables/ConfigVariables.robot

Library                   REST      ${Host}
Library                   BuiltIn
Library                   Collections
# Library                   CheckResponseSchema.py

Test Setup
Test Teardown

# Set expectations
#     Expect response       { 'status' : { 'enum': [200, 201, 204, 400] } }
#     Expect response       { 'seconds': { 'maximum': 2} }

*** Variables ***
${Host}                   https://www.sheypoor.com/api/
${EndPoint}               /general/config
@{API_Versions}           v5.9.0          v5.8.0          v3.1.5
@{Platforms}              Desktop_Web     Mobile_Site     Android
&{Android}                X-AGENT-TYPE=Android App        App-Version=5.9.0
&{Desktop_Web}            User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36
&{Mobile_Site}            User-Agent=Mozilla/5.0 (Linux; U; Android 8.1; en-us; SCH-I535 Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30

*** Test Cases ***
Test Config API
    Send Request
    # [Template]            Get Config
    # FOR     ${version}    IN       @{API_Versions}
    #         ${version} 1st arg
    # END
    # FOR     ${platform}    IN       @{Platforms}
    #         ${version} 2nd arg
    # END

*** Keywords ***
Send Request
      FOR   ${v}    IN     @{API_Versions}
            Log To Console         \nAPI Version is: ${v}
            Set Headers Value   Android
            Log To Console         \nTest Running On The Platform: Android
            ${req}=   Get                     ${v}${EndPoint}
            Log To Console  ${req} for version ${v}

            Set Headers Value   Desktop_Web
            Log To Console         \nTest Running On The Platform: Desktop Web
            ${req}=   Get                     ${v}${EndPoint}
            Log To Console  ${req} for version ${v}

            Set Headers Value   Mobile_Site
            Log To Console         \nTest Running On The Platform: Mobile Site
            ${req}=   Get                     ${v}${EndPoint}
            Log To Console  ${req} for version ${v}
      Continue For Loop
      END

Set Headers Value
      [Arguments]       ${Platform}
      FOR  ${key}   IN    @{${Platform}.keys()}
          ${value}=    Get From Dictionary     ${${Platform}}    ${key}
          Set Headers    {"key":"value"}
      END

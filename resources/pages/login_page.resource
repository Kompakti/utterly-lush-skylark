*** Settings ***
Library    Browser


*** Variables ***
${LOGIN_CONTAINER}      css=[data-test="login-container"]
${USERNAME_INPUT}       css=[data-test="username"]
${PASSWORD_INPUT}       css=[data-test="password"]
${LOGIN_BUTTON}         css=[data-test="login-button"]
${ERROR_MESSAGE}        css=[data-test="error"]
${ERROR_DISMISS_BUTTON}    css=[data-test="error-button"]


*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    Fill Username    ${username}
    Fill Password    ${password}
    Click Login Button

Fill Username
    [Arguments]    ${username}
    Fill Text    ${USERNAME_INPUT}    ${username}

Fill Password
    [Arguments]    ${password}
    Fill Secret    ${PASSWORD_INPUT}    $password

Click Login Button
    Click    ${LOGIN_BUTTON}

Get Error Message
    ${message}=    Get Text    ${ERROR_MESSAGE}
    RETURN    ${message}

Error Message Should Be Visible
    Get Element States    ${ERROR_MESSAGE}    contains    visible

Dismiss Error Message
    Click    ${ERROR_DISMISS_BUTTON}

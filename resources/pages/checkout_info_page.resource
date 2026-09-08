*** Settings ***
Library    Browser


*** Variables ***
${FIRST_NAME_INPUT}      css=[data-test="firstName"]
${LAST_NAME_INPUT}       css=[data-test="lastName"]
${POSTAL_CODE_INPUT}     css=[data-test="postalCode"]
${CONTINUE_BUTTON}       css=[data-test="continue"]
${CANCEL_BUTTON}         css=[data-test="cancel"]
${ERROR_MESSAGE}         css=[data-test="error"]
${ERROR_DISMISS_BUTTON}    css=[data-test="error-button"]


*** Keywords ***
Fill First Name
    [Arguments]    ${first_name}
    Fill Text    ${FIRST_NAME_INPUT}    ${first_name}

Fill Last Name
    [Arguments]    ${last_name}
    Fill Text    ${LAST_NAME_INPUT}    ${last_name}

Fill Postal Code
    [Arguments]    ${postal_code}
    Fill Text    ${POSTAL_CODE_INPUT}    ${postal_code}

Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill First Name    ${first_name}
    Fill Last Name    ${last_name}
    Fill Postal Code    ${postal_code}

Click Continue
    Click    ${CONTINUE_BUTTON}

Click Cancel
    Click    ${CANCEL_BUTTON}

Fill Checkout Information And Continue
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Checkout Information    ${first_name}    ${last_name}    ${postal_code}
    Click Continue

Get Error Message
    ${message}=    Get Text    ${ERROR_MESSAGE}
    RETURN    ${message}

Error Message Should Be Visible
    Get Element States    ${ERROR_MESSAGE}    contains    visible

Dismiss Error Message
    Click    ${ERROR_DISMISS_BUTTON}

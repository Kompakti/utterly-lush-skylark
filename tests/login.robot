*** Settings ***
Documentation    Test the login functionality at saucedemo.com.
Library    Collections
Library    Browser
Resource    ../resources/common.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/all_items_page.resource
Variables    ../resources/data/users.py

Suite Setup       Open Saucedemo Browser
Suite Teardown    Close Browser
Test Setup        Go To    https://www.saucedemo.com/


*** Variables ***
&{INVALID_LOGIN_ERRORS}
...    locked_out_user=user has been locked out
...    nonexistent_user=Username and password do not match any user in this service


*** Test Cases ***
User Can Log In With Valid Credentials
    FOR    ${username}    IN    @{LOGINABLE_USERS}
        Go To    https://www.saucedemo.com/
        Run Keyword And Continue On Failure    Login And Verify Success    ${username}
    END

Login With Invalid Credentials Fails
    FOR    ${username}    ${expected_message}    IN    &{INVALID_LOGIN_ERRORS}
        Go To    https://www.saucedemo.com/
        Run Keyword And Continue On Failure    Verify Invalid Login Fails    ${username}    ${expected_message}
    END


*** Keywords ***
Login And Verify Success
    [Arguments]    ${username}
    Login    ${username}    ${USERS}[${username}]
    ${title}=    Get Products Title
    Should Be Equal    ${title}    Products

Verify Invalid Login Fails
    [Documentation]    Logs in as ${username}, using its real password if it is a known account
    ...    (e.g. locked_out_user) or a placeholder otherwise, and checks the resulting error message.
    [Arguments]    ${username}    ${expected_message}
    ${password}=    Get From Dictionary    ${USERS}    ${username}    default=wrong_password
    Login    ${username}    ${password}
    Error Message Should Be Visible
    ${message}=    Get Error Message
    Should Contain    ${message}    ${expected_message}

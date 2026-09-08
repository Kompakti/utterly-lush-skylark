*** Settings ***
Library    Browser
Library    OperatingSystem


*** Variables ***
${COMPLETE_HEADER}            css=[data-test="complete-header"]
${COMPLETE_TEXT}              css=[data-test="complete-text"]
${PONY_EXPRESS_IMAGE}         css=[data-test="pony-express"]
${BACK_TO_PRODUCTS_BUTTON}    css=[data-test="back-to-products"]
${GENERATE_PDF_BUTTON}        css=[data-test="generate-pdf-order"]


*** Keywords ***
Get Complete Header
    ${header}=    Get Text    ${COMPLETE_HEADER}
    RETURN    ${header}

Get Complete Text
    ${text}=    Get Text    ${COMPLETE_TEXT}
    RETURN    ${text}

Order Should Be Complete
    Get Element States    ${COMPLETE_HEADER}    contains    visible
    ${header}=    Get Complete Header
    Should Be Equal    ${header}    Thank you for your order!

Click Back To Products
    Click    ${BACK_TO_PRODUCTS_BUTTON}

Click Generate PDF Order
    Click    ${GENERATE_PDF_BUTTON}

Generate PDF Order And Verify Download
    [Documentation]    Clicks "Generate PDF order" and asserts that a file was downloaded.
    ...    Only checks that the download happened - PDF content verification is out of scope for now.
    ${promise}=    Promise To Wait For Download
    Click Generate PDF Order
    @{downloads}=    Wait For All Promises
    ${download}=    Set Variable    ${downloads}[0]
    File Should Exist    ${download}[saveAs]
    RETURN    ${download}[saveAs]

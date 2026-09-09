*** Settings ***
Documentation    Test the purchase flow functionality at saucedemo.com.
Library    Browser
Library    Collections
Library    ../resources/SauceUtils.py
Resource    ../resources/common.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/all_items_page.resource
Resource    ../resources/pages/shopping_cart_page.resource
Resource    ../resources/pages/checkout_info_page.resource
Resource    ../resources/pages/checkout_overview_page.resource
Resource    ../resources/pages/checkout_complete_page.resource
Variables    ../resources/data/users.py
Variables    ../resources/data/products.py

Suite Setup       Open Saucedemo Browser
Suite Teardown    Close Browser
Test Setup        Go To    https://www.saucedemo.com/


*** Variables ***
${first_name}    foo
${last_name}    bar
${zip_code}    12345


*** Test Cases ***
User Can Complete A Purchase
    Login    standard_user    ${USERS}[standard_user]
    ${items}=    Pick Two Random Items
    FOR    ${item}    IN    @{items}
        Add Product To Cart    ${item}
    END
    Open Shopping Cart
    Verify Cart Item Names    ${items}
    FOR    ${item}    IN    @{items}
        Verify Cart Item Quantity    ${item}
        Verify Cart Item Description    ${item}
        Verify Cart Item Price    ${item}
    END
    Checkout
    Fill Checkout Information And Continue    ${first_name}    ${last_name}    ${zip_code}
    Verify Checkout Item Names    ${items}
    FOR    ${item}    IN    @{items}
        Verify Checkout Item Quantity    ${item}
        Verify Checkout Item Description    ${item}
        Verify Checkout Item Price    ${item}
    END
    Verify Total Price    ${items}
    Click Finish
    Order Should Be Complete
    Generate PDF Order And Verify Download


*** Keywords ***
Pick Two Random Items
    ${product_names}=    Get Dictionary Keys    ${PRODUCTS}
    ${items}=    Evaluate    random.sample($product_names, 2)
    RETURN    ${items}

Verify Cart Item Names
    [Arguments]    ${expected_items}
    ${actual_items}=    Get Cart Item Names
    Lists Should Be Equal    ${expected_items}    ${actual_items}    ignore_order=True

Verify Cart Item Quantity
    [Arguments]    ${item}
    ${quantity}=    Get Cart Item Quantity    ${item}
    Should Be Equal    ${quantity}    1

Verify Cart Item Description
    [Arguments]    ${item}
    ${desc}=    Get Cart Item Description    ${item}
    Should Be Equal    ${desc}    ${PRODUCTS}[${item}][description]

Verify Cart Item Price
    [Arguments]    ${item}
    ${price}=    Get Cart Item Price    ${item}
    Should Be Equal    ${price}    ${PRODUCTS}[${item}][price]

Verify Checkout Item Names
    [Arguments]    ${expected_items}
    ${actual_items}=    Get Checkout Item Names
    Lists Should Be Equal    ${expected_items}    ${actual_items}    ignore_order=True

Verify Checkout Item Quantity
    [Arguments]    ${item}
    ${quantity}=    Get Checkout Item Quantity    ${item}
    Should Be Equal    ${quantity}    1

Verify Checkout Item Description
    [Arguments]    ${item}
    ${desc}=    Get Checkout Item Description    ${item}
    Should Be Equal    ${desc}    ${PRODUCTS}[${item}][description]

Verify Checkout Item Price
    [Arguments]    ${item}
    ${price}=    Get Checkout Item Price    ${item}
    Should Be Equal    ${price}    ${PRODUCTS}[${item}][price]

Verify Total Price
    [Arguments]    ${items}
    ${item_prices}=    Create List
    FOR    ${item}    IN    @{items}
        Append To List    ${item_prices}    ${PRODUCTS}[${item}][price]
    END
    ${expected_subtotal}=    Calculate Subtotal Price    ${item_prices}
    ${sub_total}=    Get Item Total    parse_as_number=${TRUE}
    Should Be Equal    ${sub_total}    ${expected_subtotal}
    ${tax}=    Get Tax    parse_as_number=${TRUE}
    ${total_price}=    Get Total    parse_as_number=${TRUE}
    Should Be Equal As Numbers    ${total_price}    ${{$tax + $expected_subtotal}}    precision=2
    Should Be Less Than    ${tax}    ${expected_subtotal}

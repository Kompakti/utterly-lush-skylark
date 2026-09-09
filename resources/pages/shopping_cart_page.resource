*** Settings ***
Library    Browser
Library    Collections


*** Variables ***
${CART_TITLE}            css=[data-test="title"]
${CART_BADGE}            css=[data-test="shopping-cart-badge"]
${CART_LIST}             css=[data-test="cart-list"]
${CART_ITEM}             css=[data-test="inventory-item"]
${ITEM_NAME}             css=[data-test="inventory-item-name"]
${ITEM_DESCRIPTION}      css=[data-test="inventory-item-desc"]
${ITEM_PRICE}            css=[data-test="inventory-item-price"]
${ITEM_QUANTITY}         css=[data-test="item-quantity"]
${CHECKOUT_BUTTON}       css=[data-test="checkout"]


*** Keywords ***
Get Cart Item Locator
    [Documentation]    Builds a locator scoped to the cart item matching the given product name.
    [Arguments]    ${product_name}
    RETURN    css=.cart_item:has-text("${product_name}")

Get Cart Item Count
    ${count}=    Get Element Count    ${CART_ITEM}
    RETURN    ${count}

Get Cart Item Names
    ${elements}=    Get Elements    ${ITEM_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${name}=    Get Text    ${element}
        Append To List    ${names}    ${name}
    END
    RETURN    ${names}

Get Cart Badge Count
    [Documentation]    Returns the cart badge number, or 0 if the cart is empty (no badge element rendered).
    ${badge_count}=    Get Element Count    ${CART_BADGE}
    IF    ${badge_count} == 0
        RETURN    ${0}
    END
    ${badge_text}=    Get Text    ${CART_BADGE}
    RETURN    ${badge_text}

Get Cart Item Quantity
    [Arguments]    ${product_name}
    ${item}=    Get Cart Item Locator    ${product_name}
    ${quantity}=    Get Text    ${item} >> ${ITEM_QUANTITY}
    RETURN    ${quantity}

Get Cart Item Price
    [Arguments]    ${product_name}
    ${item}=    Get Cart Item Locator    ${product_name}
    ${price}=    Get Text    ${item} >> ${ITEM_PRICE}
    RETURN    ${price}

Get Cart Item Description
    [Arguments]    ${product_name}
    ${item}=    Get Cart Item Locator    ${product_name}
    ${description}=    Get Text    ${item} >> ${ITEM_DESCRIPTION}
    RETURN    ${description}

Checkout
    Click    ${CHECKOUT_BUTTON}

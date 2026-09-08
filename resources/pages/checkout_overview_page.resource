*** Settings ***
Library    Browser


*** Variables ***
${CHECKOUT_TITLE}         css=[data-test="title"]
${CART_LIST}              css=[data-test="cart-list"]
${CHECKOUT_ITEM}          css=[data-test="inventory-item"]
${ITEM_NAME}              css=[data-test="inventory-item-name"]
${ITEM_DESCRIPTION}       css=[data-test="inventory-item-desc"]
${ITEM_PRICE}             css=[data-test="inventory-item-price"]
${ITEM_QUANTITY}          css=[data-test="item-quantity"]
${PAYMENT_INFO_VALUE}     css=[data-test="payment-info-value"]
${SHIPPING_INFO_VALUE}    css=[data-test="shipping-info-value"]
${SUBTOTAL_LABEL}         css=[data-test="subtotal-label"]
${TAX_LABEL}              css=[data-test="tax-label"]
${TOTAL_LABEL}            css=[data-test="total-label"]
${CANCEL_BUTTON}          css=[data-test="cancel"]
${FINISH_BUTTON}          css=[data-test="finish"]


*** Keywords ***
Get Checkout Item Locator
    [Documentation]    Builds a locator scoped to the checkout item matching the given product name.
    [Arguments]    ${product_name}
    RETURN    css=.cart_item:has-text("${product_name}")

Get Checkout Item Count
    ${count}=    Get Element Count    ${CHECKOUT_ITEM}
    RETURN    ${count}

Get Checkout Item Names
    ${names}=    Get Text    ${ITEM_NAME}    All
    RETURN    ${names}

Get Item Quantity
    [Arguments]    ${product_name}
    ${item}=    Get Checkout Item Locator    ${product_name}
    ${quantity}=    Get Text    ${item} >> ${ITEM_QUANTITY}
    RETURN    ${quantity}

Get Item Price
    [Arguments]    ${product_name}
    ${item}=    Get Checkout Item Locator    ${product_name}
    ${price}=    Get Text    ${item} >> ${ITEM_PRICE}
    RETURN    ${price}

Get Item Description
    [Arguments]    ${product_name}
    ${item}=    Get Checkout Item Locator    ${product_name}
    ${description}=    Get Text    ${item} >> ${ITEM_DESCRIPTION}
    RETURN    ${description}

Get Payment Information
    ${payment_info}=    Get Text    ${PAYMENT_INFO_VALUE}
    RETURN    ${payment_info}

Get Shipping Information
    ${shipping_info}=    Get Text    ${SHIPPING_INFO_VALUE}
    RETURN    ${shipping_info}

Get Item Total
    [Documentation]    Returns the item total label. Pass ${TRUE} for parse_as_number to get the numeric
    ...    value (e.g. 25.98) instead of the full label text (e.g. "Item total: $25.98").
    [Arguments]    ${parse_as_number}=${FALSE}
    ${text}=    Get Text    ${SUBTOTAL_LABEL}
    IF    ${parse_as_number}
        ${value}=    Evaluate    float('''${text}'''.rsplit('$', 1)[-1])
        RETURN    ${value}
    END
    RETURN    ${text}

Get Tax
    [Documentation]    Returns the tax label. Pass ${TRUE} for parse_as_number to get the numeric
    ...    value (e.g. 2.08) instead of the full label text (e.g. "Tax: $2.08").
    [Arguments]    ${parse_as_number}=${FALSE}
    ${text}=    Get Text    ${TAX_LABEL}
    IF    ${parse_as_number}
        ${value}=    Evaluate    float('''${text}'''.rsplit('$', 1)[-1])
        RETURN    ${value}
    END
    RETURN    ${text}

Get Total
    [Documentation]    Returns the total label. Pass ${TRUE} for parse_as_number to get the numeric
    ...    value (e.g. 28.06) instead of the full label text (e.g. "Total: $28.06").
    [Arguments]    ${parse_as_number}=${FALSE}
    ${text}=    Get Text    ${TOTAL_LABEL}
    IF    ${parse_as_number}
        ${value}=    Evaluate    float('''${text}'''.rsplit('$', 1)[-1])
        RETURN    ${value}
    END
    RETURN    ${text}

Click Finish
    Click    ${FINISH_BUTTON}

Click Cancel
    Click    ${CANCEL_BUTTON}

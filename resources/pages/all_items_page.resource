*** Settings ***
Library    Browser


*** Variables ***
# Header
${PRODUCTS_TITLE}           css=[data-test="title"]
${SHOPPING_CART_LINK}       css=[data-test="shopping-cart-link"]

# Inventory list
${INVENTORY_CONTAINER}      css=[data-test="inventory-container"]
${INVENTORY_LIST}           css=[data-test="inventory-list"]
${INVENTORY_ITEM}           css=[data-test="inventory-item"]
${ITEM_NAME}                css=[data-test="inventory-item-name"]
${ITEM_DESCRIPTION}         css=[data-test="inventory-item-desc"]
${ITEM_PRICE}               css=[data-test="inventory-item-price"]
${ADD_TO_CART_BUTTON}       css=button.btn_inventory


*** Keywords ***
Get Products Title
    [Documentation]    Returns the "Products" page heading text.
    ${title}=    Get Text    ${PRODUCTS_TITLE}
    RETURN    ${title}

Open Shopping Cart
    Click    ${SHOPPING_CART_LINK}

Get Product Names
    [Documentation]    Returns the list of product names currently displayed.
    ${names}=    Get Text    ${ITEM_NAME}    All
    RETURN    ${names}

Get Product Locator
    [Documentation]    Builds a locator scoped to the inventory item matching the given product name.
    [Arguments]    ${product_name}
    RETURN    css=.inventory_item:has-text("${product_name}")

Get Product Price
    [Arguments]    ${product_name}
    ${item}=    Get Product Locator    ${product_name}
    ${price}=    Get Text    ${item} >> ${ITEM_PRICE}
    RETURN    ${price}

Get Product Description
    [Arguments]    ${product_name}
    ${item}=    Get Product Locator    ${product_name}
    ${description}=    Get Text    ${item} >> ${ITEM_DESCRIPTION}
    RETURN    ${description}

Add Product To Cart
    [Arguments]    ${product_name}
    ${item}=    Get Product Locator    ${product_name}
    Click    ${item} >> ${ADD_TO_CART_BUTTON}

Remove Product From Cart
    [Documentation]    The Add to cart button becomes a Remove button once the product is added.
    [Arguments]    ${product_name}
    ${item}=    Get Product Locator    ${product_name}
    Click    ${item} >> ${ADD_TO_CART_BUTTON}

Open Product Details
    [Arguments]    ${product_name}
    Click    text=${product_name}

*** Settings ***
Library    Browser


*** Variables ***
${OPEN_MENU_BUTTON}         css=#react-burger-menu-btn
${CLOSE_MENU_BUTTON}        css=#react-burger-cross-btn
${MENU_WRAP}                css=.bm-menu-wrap

${ALL_ITEMS_LINK}           css=[data-test="inventory-sidebar-link"]
${ABOUT_LINK}                css=[data-test="about-sidebar-link"]
${LOGOUT_LINK}               css=[data-test="logout-sidebar-link"]
${RESET_APP_STATE_LINK}      css=[data-test="reset-sidebar-link"]


*** Keywords ***
Open Hamburger Menu
    Click    ${OPEN_MENU_BUTTON}
    Get Attribute    ${MENU_WRAP}    aria-hidden    ==    false

Close Hamburger Menu
    Click    ${CLOSE_MENU_BUTTON}
    Get Attribute    ${MENU_WRAP}    aria-hidden    ==    true

Go To All Items
    Open Hamburger Menu
    Click    ${ALL_ITEMS_LINK}

Go To About
    Open Hamburger Menu
    Click    ${ABOUT_LINK}

Logout
    Open Hamburger Menu
    Click    ${LOGOUT_LINK}

Reset App State
    Open Hamburger Menu
    Click    ${RESET_APP_STATE_LINK}
    Close Hamburger Menu

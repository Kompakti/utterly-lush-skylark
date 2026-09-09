*** Settings ***
Library    Browser


*** Keywords ***
Open Saucedemo Browser
    New Browser    firefox    timeout=3 s
    New Context    acceptDownloads=True
    New Page    https://www.saucedemo.com/

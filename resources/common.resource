*** Settings ***
Library    Browser


*** Keywords ***
Open Saucedemo Browser
    New Browser    firefox
    New Context    acceptDownloads=True
    New Page    https://www.saucedemo.com/

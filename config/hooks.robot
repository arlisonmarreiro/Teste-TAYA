*** Settings ***

Resource      package.robot

*** Keywords ***

Open Page
    Open Browser    browser=${BROWSER}    url=${URL}    options=add_experimental_option("detach", True)
    Maximize Browser Window

Close Page
    Close Browser
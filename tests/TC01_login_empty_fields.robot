*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC01 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC01    login    negative

*** Test Cases ***
Prázdne políčka pri prihlasovaní
    [Documentation]    Overí, že pri pokuse o login bez mena a hesla sa zobrazia povinné validácie.
    Click Local Submit
    Verify Required Messages

*** Keywords ***
TC01 Suite Setup
    Open Chrome Browser Safely
    Open Home Page
    Open Login From Left Sidebar
    Ensure Local Login Form Visible

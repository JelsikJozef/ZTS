*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC10 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC10    profile    negative

*** Test Cases ***
TC10 - Zadanie nesprávnej adresy email ("admin1")
    [Documentation]
    ...    Overí validáciu poľa "Email" v nastaveniach profilu pre neplatný vstup admin1.
    ...    Očakávanie: zobrazí sa upozornenie na nesprávnu adresu email (test PASS).

    Input Email    ${INVALID_EMAIL}
    Save Profile Changes
    Verify Invalid Email Message
    Capture Page Screenshot

*** Keywords ***
TC10 Suite Setup
    Open Sign In Page
    Login As Teacher
    Open Settings Via User Menu

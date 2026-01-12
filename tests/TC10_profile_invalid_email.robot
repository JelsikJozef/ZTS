*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC10    profile    negative

*** Test Cases ***
TC10 - Zadanie nesprávnej adresy email ("admin1")
    [Documentation]
    ...    Test overuje validáciu poľa "Email" v nastaveniach profilu.
    ...    Očakávanie: po zadaní hodnoty admin1 sa zobrazí upozornenie na nesprávny email.
    ...    Skutočný výsledok: validácia by mala fungovať → test PASS.

    Login As Teacher
    Open Settings Via User Menu

    Input Email    ${INVALID_EMAIL}
    Save Profile Changes

    Verify Invalid Email Message


*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC06    profile    negative

*** Test Cases ***
TC06 - Zadanie krátkeho čísla do tel.č. v nastaveniach (67)
    Login As Teacher
    Open Settings Via User Menu

    Input Phone    ${INVALID_PHONE_SHORT}
    Save Profile Changes

    Verify Phone Validation Error

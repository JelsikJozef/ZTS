*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC07 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC07    profile    positive

*** Test Cases ***
TC07 - Zadanie správneho telefónneho čísla do profilu
    [Documentation]
    ...    Overí, že po zadaní správneho telefónneho čísla
    ...    sa hodnota korektne uloží a ostane uložená po refreshi.

    Input Phone    ${VALID_PHONE}
    Save Profile Changes
    Verify Phone Saved    ${VALID_PHONE}

*** Keywords ***
TC07 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Open Settings Via User Menu

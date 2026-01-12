*** Test Cases ***
*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC07    profile    positive

*** Test Cases ***
TC07 - Zadanie správneho telefónneho čísla do profilu
    [Documentation]
    ...    Test overuje, že po zadaní správneho telefónneho čísla
    ...    sa hodnota korektne uloží do profilu používateľa.
    ...    Očakávaný výsledok: PASS.

    Login As Teacher
    Open Settings Via User Menu

    Input Phone    ${VALID_PHONE}
    Save Profile Changes

    Verify Phone Was Saved Successfully

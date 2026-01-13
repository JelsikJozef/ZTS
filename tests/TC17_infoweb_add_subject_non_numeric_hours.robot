*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC17    infoweb    negative    bug

*** Test Cases ***
TC17 - Predmet s nečíselným počtom hodín
    [Documentation]    Overí, že Počet hodín musí byť číslo. Očakávame chybu, no aktuálne sa predmet vytvorí (BUG).
    Login As Portaladmin
    Open Info Web Tab
    Open Manage Subjects
    Open Add New Subject Form
    ${epoch}=    Get Time    epoch
    ${unique_code}=    Catenate    SEPARATOR=    ${SUBJ_CODE_NONNUM_HOURS}${epoch}
    Fill Subject Form    ${SUBJ_NAME_NONNUM_HOURS}    ${unique_code}    ${SUBJ_GUARANT_NONNUM_HOURS}    ${SUBJ_HOURS_NONNUM}    ${SUBJ_CREDITS_OK}
    Submit Subject Form
    Verify Hours Must Be Numeric Error
    Capture Page Screenshot


*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC16    infoweb    negative    bug

*** Test Cases ***
TC16 - Vytvorenie predmetu s nulovými kreditmi
    [Documentation]    Overí, že predmet s kreditmi = 0 má byť odmietnutý (očakávaná chyba), no systém ho aktuálne vytvorí – test tým odhalí BUG.
    Login As Portaladmin
    Open Info Web Tab
    Open Manage Subjects
    Open Add New Subject Form
    Fill Subject Form    ${SUBJ_NAME_ZERO}    ${SUBJ_CODE_ZERO}    ${SUBJ_GUARANT_ZERO}    ${SUBJ_HOURS_ZERO}    ${SUBJ_CREDITS_ZERO}
    Submit Subject Form
    Verify Credits Must Be Greater Than Zero Error
    Capture Page Screenshot


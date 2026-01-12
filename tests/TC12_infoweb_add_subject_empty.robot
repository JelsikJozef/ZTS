*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC12    infoweb    negative

*** Test Cases ***
TC12 - Pridanie predmetu s prázdnymi údajmi
    [Documentation]
    ...    Overí validáciu pri pokuse pridať predmet bez vyplnenia polí.
    ...    Kroky: login ako portaladmin, preklik na Informačný web -> Spravovať predmety -> Pridať nový predmet -> prázdny submit.
    ...    Očakávanie: zobrazenie chyby na povinné polia → test PASS.

    Login As Portaladmin
    Open Info Web Tab
    Open Manage Subjects
    Open Add New Subject Form
    Submit Empty Subject
    Verify Subject Empty Fields Errors


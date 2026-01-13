*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC12 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC12    infoweb    negative

*** Test Cases ***
TC12 - Pridanie predmetu s prázdnymi údajmi
    [Documentation]
    ...    Overí validáciu pri pokuse pridať predmet bez vyplnenia polí.
    ...    Očakávanie: zobrazenie chyby na povinné polia → test PASS.

    Submit Empty Subject
    Verify Subject Empty Fields Errors

*** Keywords ***
TC12 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Open Info Web Tab
    Open Manage Subjects
    Open Add New Subject Form

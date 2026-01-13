*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC13    infoweb    negative

*** Test Cases ***
TC13 - Pridanie nového pracovníka s prázdnymi údajmi
    [Documentation]
    ...    Overí validáciu pri pokuse pridať zamestnanca bez vyplnenia polí.
    ...    Kroky: login ako portaladmin, Informačný web -> Spravovať pracovníkov -> Pridať nového zamestnanca -> prázdny submit.
    ...    Očakávanie: zobrazenie chyby na povinné polia → test PASS.

    Login As Portaladmin
    Open Info Web Tab
    Open Manage Employees
    Open Add New Employee Form
    Submit Empty Employee
    Verify Employee Empty Fields Errors


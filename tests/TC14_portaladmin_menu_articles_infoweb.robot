*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TCxx    smoke    portaladmin    access

*** Test Cases ***
TC14 - Možnosť úpravy článkov a infowebu portaladminom
    [Documentation]
    ...    Overí, že portaladmin po prihlásení vidí menu položky "Články" a "Informačný web".
    Login As Portaladmin
    Verify Portaladmin Sees Articles And Infoweb


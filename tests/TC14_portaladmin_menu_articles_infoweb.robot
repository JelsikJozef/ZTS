*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC14 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       portaladmin    smoke    access

*** Test Cases ***
TC14 - Možnosť úpravy článkov a informačného webu portaladminom
    [Documentation]
    ...    Overí, že portaladmin po prihlásení vidí v menu položky "Články" a "Informačný web".
    Verify Portaladmin Sees Articles And Infoweb

*** Keywords ***
TC14 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Ensure Menu Expanded

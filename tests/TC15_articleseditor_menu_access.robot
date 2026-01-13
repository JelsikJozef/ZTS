*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC15 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC15    articles    access    positive

*** Test Cases ***
TC15 - Možnosť úpravy článkov webu articleseditorom
    [Documentation]
    ...    Overí, že účet articleseditor vidí v menu položku "Články" a zároveň nevidí/neexistuje "Informačný web".
    Verify Articles Visible And Infoweb Hidden

*** Keywords ***
TC15 Suite Setup
    Open Sign In Page
    Login As Articleseditor
    Ensure Menu Expanded

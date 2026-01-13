*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC15    smoke    articles    access    articleseditor

*** Test Cases ***
TC15 - Articleseditor vidí Články a nevidí Informačný web
    [Documentation]
    ...    Overí, že účet articleseditor má prístup k menu položke "Články" a nemá prístup k "Informačný web".
    Login As Portaladmin
    Verify Articles Visible And Infoweb Hidden

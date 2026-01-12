*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC11    articles    negative

*** Test Cases ***
TC11 - Vymazanie údajov v existujúcom článku
    [Documentation]
    ...    Test overuje validáciu pri vymazaní názvu a obsahu existujúceho článku.
    ...    Očakávanie: po uložení prázdnych polí sa zobrazí validačná chyba → test PASS.

    Login As Articles Editor
    Open First Article From Home

    Open Article Edit
    Clear Article Title And Content
    Save Article

    Verify Article Empty Error


*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC11 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC11    articles    negative

*** Test Cases ***
TC11 - Vymazanie údajov v existujúcom článku
    [Documentation]
    ...    Test overuje validáciu pri vymazaní názvu a obsahu existujúceho článku.
    ...    Očakávanie: po uložení prázdnych polí sa zobrazí validačná chyba → test PASS.

    Clear Article Title And Content
    Save Article
    Verify Article Empty Error

*** Keywords ***
TC11 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Open First Article From Home
    Open Article Edit

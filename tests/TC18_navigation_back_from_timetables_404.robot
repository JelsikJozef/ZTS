*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC18 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC18    navigation    negative    bug

*** Test Cases ***
TC18 - Navigácia späť z Rozvrhov (BUG 404)
    [Documentation]
    ...    Overí, že po otvorení stránky Rozvrhy (/timetables) a návrate späť (browser back šípka vľavo)
    ...    sa používateľ vráti na homepage (/). Aktuálne sa zobrazí „Ooops… 404!“ → BUG.
    Open Timetables From Menu
    Browser Back And Verify Home

*** Keywords ***
TC18 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Ensure Menu Expanded


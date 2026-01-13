*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC18 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC18    navigation    negative    bug

*** Test Cases ***
TC18 - Navigácia späť z Rozvrhov vedie na 404 (BUG)
    [Documentation]    Overí, že po návrate z /timetables späť sa má otvoriť homepage; aktuálne sa zobrazí 404 → BUG.
    Open Timetables From Menu
    Browser Back And Verify Home

*** Keywords ***
TC18 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Open Home Page


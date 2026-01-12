*** Test Cases ***
*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC05    profile    negative    bug

*** Test Cases ***
TC05 - Zadanie nečíselných znakov do tel. čísla v nastaveniach
    [Documentation]
    ...    TestSem – Zadanie nečíselných znakov do tel. č. v nastaveniach
    ...
    ...    Test Scenario:
    ...    Overiť, či aplikácia validuje pole "Telefón" a zakáže
    ...    uloženie nečíselných znakov.
    ...
    ...    Očakávané správanie:
    ...    - údaje sa NEULOŽIA
    ...
    ...    Skutočné správanie:
    ...    - údaje sa uložia → BUG

    # 1. Prihlásenie ako portaladmin
    Select Local Account Login
    Input Username    ${USER_PORTALADMIN}
    Input Password    nimdalatrop
    Submit Local Login
    Wait Until Page Contains    Aktuality    20s

    # 2. Otvorenie nastavení profilu
    Open Settings Via User Menu

    # 3. Zadanie nečíselných znakov do poľa Telefón
    Input Phone Number    kapustnica

    # 4. Uloženie zmien
    Save Profile Changes

    # Poznámka:
    # Podľa špecifikácie by sa údaje nemali uložiť,
    # ale aplikácia ich uloží → TEST FAIL (BUG)
    Capture Page Screenshot
    # OČAKÁVANÉ: systém má vypísať chybu a neuložiť
    Wait Until Page Contains    ${MSG_PHONE_INVALID}    10s
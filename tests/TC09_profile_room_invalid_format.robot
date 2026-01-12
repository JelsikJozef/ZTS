*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC09    profile    negative

*** Test Cases ***
TC09 - Zadanie miestnosti v nesprávnom formáte ("Hore")
    [Documentation]
    ...    Test overuje validáciu poľa "Miestnosť" v nastaveniach profilu.
    ...    Očakávané správanie: zobrazí sa validačná chyba pre nesprávny formát.
    ...    Skutočné správanie: hodnota sa uloží → BUG (test má spadnúť na chýbajúcej chybe).

    Login As Teacher
    Open Settings Via User Menu

    Input Room    ${INVALID_ROOM}
    Save Profile Changes

    # Očakávame validačnú chybu (ak sa neobjaví, keyword zlyhá a označí BUG)
    Verify Room Format Error


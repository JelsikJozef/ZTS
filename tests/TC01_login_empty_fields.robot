*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session

*** Test Cases ***
Prázdne políčka pri prihlasovaní
    [Documentation]    Test funkcionality prihlasovania bez zadania údajov

    # Krok 3 – lokálny účet
    Select Local Account Login
    Ensure Local Login Form Visible

    # Krok 4 – submit bez údajov
    Click Local Submit
    Verify Required Messages

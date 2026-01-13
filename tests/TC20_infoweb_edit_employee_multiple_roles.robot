*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC20 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC20    infoweb    negative    bug

*** Test Cases ***
TC20 - Úprava zamestnanca s viacerými rolami (BUG)
    [Documentation]    Overí, že pri úprave zamestnanca možno omylom zvoliť viac rolí a uložiť (BUG). Test očakáva, že validácia sa zobrazí; ak nie, FAIL.
    Select Employee Role By Text     ${ROLE_1}
    Select Employee Role By Text     ${ROLE_2}
    Assert Role Checked              ${ROLE_1}
    Assert Role Checked              ${ROLE_2}
    Save Employee Changes
    Verify Multi Role Not Allowed Error
    # Cleanup: nechaj len jednu rolu (ROLE_1) ak sa uloženie prešlo
    Run Keyword And Ignore Error    Select Employee Role By Text    ${ROLE_2}
    Run Keyword And Ignore Error    Save Employee Changes
    Capture Page Screenshot

*** Keywords ***
TC20 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Open Info Web Tab
    Open Manage Employees
    Open First Employee From Current Employees


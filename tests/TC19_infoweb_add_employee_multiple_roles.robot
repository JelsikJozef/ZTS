*** Settings ***
Resource        ../resources/common.robot
Suite Setup     TC19 Suite Setup
Suite Teardown  Close Browser Session
Test Tags       TC19    infoweb    negative    bug

*** Test Cases ***
TC19 - Pridávaný zamestnanec s viacerými rolami
    [Documentation]    Overí, že systém by nemal povoliť výber viacerých rolí naraz pri pridaní zamestnanca. Očakávame chybu; ak sa neobjaví, test odhalí BUG.
    ${epoch}=    Get Time    epoch
    ${unique_ldap}=    Catenate    SEPARATOR=_    ${EMP_LDAP_MULTIROLE}    ${epoch}
    ${unique_email}=   Catenate    SEPARATOR=_    ${EMP_EMAIL_MULTIROLE}    ${epoch}
    Fill Employee Required Fields    ${EMP_NAME_MULTIROLE}    ${unique_ldap}    ${unique_email}
    Select Employee Role By Text     ${ROLE_1}
    Select Employee Role By Text     ${ROLE_2}
    Submit Employee Form
    Verify Multi Role Not Allowed Error
    Capture Page Screenshot

*** Keywords ***
TC19 Suite Setup
    Open Sign In Page
    Login As Portaladmin
    Open Info Web Tab
    Open Manage Employees
    Open Add New Employee Form

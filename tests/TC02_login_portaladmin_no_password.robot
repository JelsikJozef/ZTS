*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session

*** Test Cases ***
Prihlásenie portaladmin bez hesla
    [Tags]    login    negative
    Select Local Account Login
    Input Username    ${USER_PORTALADMIN}
    Input Password    ${EMPTY}
    Submit Local Login
    Verify Password Required Message

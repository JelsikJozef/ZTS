*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session

*** Test Cases ***
Prihlásenie portaladmin so zlým heslom
    [Documentation]    Test funkcionality prihlasovania sa do portaladmin so zlým heslom
    [Tags]    login    negative

    Select Local Account Login
    Input Username    ${USER_PORTALADMIN}
    Input Password    zleheslo
    Submit Local Login
    Verify Wrong Credentials Message

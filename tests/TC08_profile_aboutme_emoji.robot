
*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC08    profile    positive

*** Test Cases ***
TC08 - Pridanie Emoji do popisu profilu (O mne)
    # 1-4: login ako portaladmin
    Login Local    ${USER_PORTALADMIN}    ${PASS_PORTALADMIN}

    # 5-6: user menu -> nastavenia
    Open Settings Via User Menu

    # 7: do "O mne" napíš emoji
    Input About Me    ${ABOUT_TEXT}

    # 8: uložiť zmeny
    Save Profile Changes

    # assert: po reloade musí byť text aj s emoji uložený
    Verify About Me Saved    ${ABOUT_TEXT}

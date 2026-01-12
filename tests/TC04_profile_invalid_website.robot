*** Settings ***
Resource        ../resources/common.robot
Suite Setup     Open Sign In Page
Suite Teardown  Close Browser Session
Test Tags       TC04    profile    negative

*** Variables ***
${WEBSITE_INVALID}    DobraStranka
${WEBSITE_ERROR}      xpath=//label[normalize-space(.)='Webstránka']/following::mat-error[1]

*** Test Cases ***
TC04 - Zadanie neplatnej webstránky v profile
    [Documentation]
    ...    TestSem4: Overenie validácie poľa "Webstránka" na neplatnú hodnotu.
    ...    Očakávanie: zobrazí sa validačná chyba / odmietne sa uloženie.
    ...    Ak sa hodnota uloží alebo preformátuje na URL bez chyby, ide o BUG.

    Login As Teacher
    Open Settings Via User Menu

    Input Website    ${WEBSITE_INVALID}
    Save Profile Changes

    # 1) Primárne očakávanie: musí existovať validačná chyba pri "Webstránka"
    ${has_error}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${WEBSITE_ERROR}    3s

    IF    ${has_error}
        # OK - validácia funguje
        Capture Page Screenshot
    ELSE
        # 2) Ak chyba nie je, skontroluj či sa hodnota preformátovala (BUG scenár)
        ${val}=    Get Value    ${INPUT_WEBSITE}

        # Ak aplikácia spravila z "DobraStranka" URL (napr. https://...), je to BUG => FAIL
        ${is_url}=    Run Keyword And Return Status    Should Match Regexp    ${val}    ^https?://

        IF    ${is_url}
            Capture Page Screenshot
            Fail    BUG: Neplatná webstránka nevyhodila chybu a pole sa preformátovalo na URL: ${val}
        ELSE
            Capture Page Screenshot
            Fail    Nezobrazila sa validačná chyba pre Webstránka a hodnota sa ani nepreformátovala. Aktuálna hodnota: ${val}
        END
    END

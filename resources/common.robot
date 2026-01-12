*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ./locators.robot
Resource   ./data.robot



*** Variables ***
${BROWSER}    chrome


*** Keywords ***
###############################################################################
# ZÁKLAD: spoločné otvorenie/zatvorenie + ochrana proti Chrome popupom
###############################################################################

# (spoločné pre všetky TestSem)
Open Sign In Page
    Open Chrome Browser Safely
    Go To    ${SIGNIN_URL}
    Wait Until Page Contains    Prihlásiť sa    20s

# (spoločné pre všetky TestSem)
Open Home Page
    Go To    ${BASE_URL}
    Wait Until Page Contains    Aktuality    20s

# (spoločné pre všetky TestSem)
Close Browser Session
    Close Browser

# (spoločné pre všetky TestSem) – zavrie Chrome “Zmeňte heslo” popup, ak sa objaví
Open Chrome Browser Safely
      ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    # znižuje rušivé okná
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-popup-blocking

    # vypnutie password manageru + leak detection cez prefs
    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    ...    profile.password_manager_leak_detection=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}

    Create Webdriver    Chrome    options=${options}
    Maximize Browser Window

###############################################################################
# PRIHLASENIE – lokálny účet (TestSem1–TestSem3 + použije sa aj pred profilom)
###############################################################################

# Použitie: TestSem1, TestSem2, TestSem3, TestSem4 (setup login)
Select Local Account Login
    Wait Until Element Is Visible    ${BTN_LOCAL_LOGIN}    20s
    Scroll Element Into View         ${BTN_LOCAL_LOGIN}
    Click Element                    ${BTN_LOCAL_LOGIN}

    Wait Until Page Contains    ${TXT_USERNAME_LABEL}    20s
    Wait Until Page Contains    ${TXT_PASSWORD_LABEL}    20s

# Použitie: TestSem1–TestSem3, TestSem4
Input Username
    [Arguments]    ${username}
    ${inp}=    Set Variable    xpath=//*[contains(normalize-space(.),'${TXT_USERNAME_LABEL}')]/following::input[1]
    Wait Until Element Is Visible    ${inp}    20s
    Clear Element Text               ${inp}
    Input Text                       ${inp}    ${username}

# Použitie: TestSem1–TestSem3, TestSem4
Input Password
    [Arguments]    ${password}
    ${inp}=    Set Variable    xpath=//*[contains(normalize-space(.),'${TXT_PASSWORD_LABEL}')]/following::input[1]
    Wait Until Element Is Visible    ${inp}    20s
    Clear Element Text               ${inp}
    Input Text                       ${inp}    ${password}

# Použitie: TestSem1–TestSem3, TestSem4
Submit Local Login
    Wait Until Element Is Visible    ${BTN_SUBMIT_LOCAL}    20s
    Scroll Element Into View         ${BTN_SUBMIT_LOCAL}
    Click Element                    ${BTN_SUBMIT_LOCAL}

# Použitie: TestSem1 (prázdne meno+heslo)
Verify Required Messages (Empty Username And Password)
    Wait Until Page Contains    ${MSG_USERNAME_REQUIRED}    20s
    Wait Until Page Contains    ${MSG_PASSWORD_REQUIRED}    20s
    Capture Page Screenshot

# Použitie: TestSem2 (portaladmin bez hesla)
Verify Password Required Message
    Wait Until Page Contains    ${MSG_PASSWORD_REQUIRED}    20s
    Capture Page Screenshot

# Použitie: TestSem3 (portaladmin zlé heslo)
Verify Wrong Credentials Message
    Wait Until Page Contains    Nesprávne používateľské meno alebo heslo    20s
    Capture Page Screenshot


###############################################################################
# LOGIN FLOW PRE PROFILOVÉ TESTY – (TestSem4 a ďalšie profilové)
###############################################################################

# Použitie: TestSem4 (a všetky ďalšie profilové testy)
Login As Teacher
    # Východisko: sme na /sign-in
    Select Local Account Login
    Input Username    ${USER_TEACHER}
    Input Password    ${PASS_TEACHER}
    Submit Local Login

    # počkaj na domovskú stránku po logine
    Wait Until Page Contains    Aktuality    20s
    #Dismiss Chrome Password Popup If Present


###############################################################################
# NAVIGÁCIA DO NASTAVENÍ – cez user menu (TestSem4 a ďalšie)
###############################################################################

# Použitie: TestSem4
Open Settings Via User Menu
    #Dismiss Chrome Password Popup If Present

    # 1) klik na ikonku user menu (tá čo si poslal HTML)
    Wait Until Element Is Visible    ${BTN_USER_MENU}    20s
    Click Element                    ${BTN_USER_MENU}

    # 2) klik na "Nastavenia" v menu
    Wait Until Element Is Visible    ${MENU_SETTINGS}    20s
    Click Element                    ${MENU_SETTINGS}

    # 3) over že sme na settings
    Wait Until Location Contains     /settings    20s
    Wait Until Page Contains         Nastavenia   20s

# Použitie: TestSem4 – fallback, keby menu robilo problémy
Open Settings Direct
    Go To    ${BASE_URL}settings
    Wait Until Location Contains    /settings    20s
    Wait Until Page Contains        Nastavenia   20s


###############################################################################
# PROFIL – Webstránka (TestSem4)
###############################################################################

# Použitie: TestSem4
Input Website
    [Arguments]    ${website}
    Wait Until Element Is Visible    ${INPUT_WEBSITE}    20s
    Clear Element Text               ${INPUT_WEBSITE}
    Input Text                       ${INPUT_WEBSITE}    ${website}

# Použitie: TestSem4
Save Profile Changes
    Wait Until Element Is Visible    ${BTN_SAVE_CHANGES}    20s
    Scroll Element Into View         ${BTN_SAVE_CHANGES}
    Click Element                    ${BTN_SAVE_CHANGES}

###############################################################################
# PROFIL – Telefón (TestSemXX)
###############################################################################

Input Phone Number
    [Arguments]    ${phone}
    Wait Until Element Is Visible    ${INPUT_PHONE}    20s
    Clear Element Text               ${INPUT_PHONE}
    Input Text                       ${INPUT_PHONE}    ${phone}
###############################################################################
# PROFIL – Telefón (krátke číslo)  (TestSem? / TC??)
###############################################################################

Input Phone
    [Arguments]    ${phone}
    Wait Until Element Is Visible    ${INPUT_PHONE}    20s
    Clear Element Text               ${INPUT_PHONE}
    Input Text                       ${INPUT_PHONE}    ${phone}

Verify Phone Validation Error
    # Ak aplikácia validuje, očakávame chybu.
    # Zatiaľ genericky podľa textu (upraviť na presný text, keď ho zistíš v UI)
    Wait Until Page Contains Element    css=mat-error    10s
    Capture Page Screenshot

Verify Phone Was Saved (Bug)
    # Keďže u vás to v manuálnom teste vyšlo FAIL = bug (uložilo sa),
    # tak tu overíme, že sa NEzobrazila chyba.
    ${has_error}=    Run Keyword And Return Status    Page Should Contain    ${TXT_PHONE_ERROR_GENERIC}
    IF    ${has_error}
        Capture Page Screenshot
        Fail    Očakával som, že chyba sa NEobjaví (podľa reality sa ukladá). Ale chyba sa objavila, správanie sa zmenilo.
    END
    Capture Page Screenshot


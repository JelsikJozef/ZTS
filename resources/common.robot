*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Resource   ./locators.robot
Resource   ./data.robot

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
###############################################################################
# BROWSER / ZÁKLAD
###############################################################################

Open Chrome Browser Safely
    # Vytvor ChromeOptions cez Evaluate (bez potreby extra importov)
    ${options}=    Evaluate    __import__('selenium.webdriver').webdriver.ChromeOptions()

    # menej rušivých okien
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-popup-blocking

    # vypnúť password manager + leak detection
    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    ...    profile.password_manager_leak_detection=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}

    Create Webdriver    Chrome    options=${options}
    Maximize Browser Window

Open Sign In Page
    Open Chrome Browser Safely
    Go To    ${SIGNIN_URL}
    Wait Until Page Contains    Prihlásiť sa    20s

Open Home Page
    Go To    ${BASE_URL}
    Wait Until Page Contains    Aktuality    20s

Close Browser Session
    Close Browser

Take Screenshot On Failure
    [Arguments]    ${msg}
    Capture Page Screenshot
    Fail    ${msg}

###############################################################################
# LOGIN – lokálny účet (TC01–TC03)
###############################################################################

Select Local Account Login
    Wait Until Element Is Visible    ${BTN_LOCAL_LOGIN}    20s
    Scroll Element Into View         ${BTN_LOCAL_LOGIN}
    Click Element                    ${BTN_LOCAL_LOGIN}
    Wait Until Page Contains         ${TXT_USERNAME_LABEL}    20s
    Wait Until Page Contains         ${TXT_PASSWORD_LABEL}    20s

Input Username
    [Arguments]    ${username}
    ${inp}=    Set Variable    xpath=//*[contains(normalize-space(.),'${TXT_USERNAME_LABEL}')]/following::input[1]
    Wait Until Element Is Visible    ${inp}    20s
    Clear Element Text               ${inp}
    Input Text                       ${inp}    ${username}

Input Password
    [Arguments]    ${password}
    ${inp}=    Set Variable    xpath=//*[contains(normalize-space(.),'${TXT_PASSWORD_LABEL}')]/following::input[1]
    Wait Until Element Is Visible    ${inp}    20s
    Clear Element Text               ${inp}
    Input Text                       ${inp}    ${password}

Submit Local Login
    Wait Until Element Is Visible    ${BTN_SUBMIT_LOCAL}    20s
    Scroll Element Into View         ${BTN_SUBMIT_LOCAL}
    Click Element                    ${BTN_SUBMIT_LOCAL}

Login Local
    [Arguments]    ${username}    ${password}
    Select Local Account Login
    Input Username    ${username}
    Input Password    ${password}
    Submit Local Login
    Wait Until Page Contains    Aktuality    20s

Verify Required Messages Empty Username And Password
    Wait Until Page Contains    ${MSG_USERNAME_REQUIRED}    20s
    Wait Until Page Contains    ${MSG_PASSWORD_REQUIRED}    20s
    Capture Page Screenshot

Verify Password Required Message
    Wait Until Page Contains    ${MSG_PASSWORD_REQUIRED}    20s
    Capture Page Screenshot

Verify Wrong Credentials Message
    Wait Until Page Contains    Nesprávne používateľské meno alebo heslo    20s
    Capture Page Screenshot

Open Login From Left Sidebar
    [Documentation]    Klikne na položku "Prihlásiť sa" v ľavej lište na domovskej stránke.
    Wait Until Element Is Visible    ${BTN_LOGIN_SIDEBAR}    15s
    Scroll Element Into View         ${BTN_LOGIN_SIDEBAR}
    Click Element                    ${BTN_LOGIN_SIDEBAR}
    Wait Until Page Contains         Prihlásiť sa    10s

Ensure Local Login Form Visible
    [Documentation]    Pre starší TC01 alias: zabezpečí, že lokálny login formulár je zobrazený.
    Select Local Account Login

Click Local Submit
    [Documentation]    Pre starší TC01 alias: klikne na submit lokálneho loginu bez vyplnenia.
    Submit Local Login

Verify Required Messages
    [Documentation]    Pre starší TC01 alias: overí povinné polia.
    Verify Required Messages Empty Username And Password

###############################################################################
# LOGIN FLOW PRE PROFILOVÉ TESTY
###############################################################################

Login As Teacher
    Login Local    ${USER_TEACHER}    ${PASS_TEACHER}

###############################################################################
# NAVIGÁCIA – Nastavenia
###############################################################################

Open Settings Via User Menu
    Wait Until Element Is Visible    ${BTN_USER_MENU}    20s
    Click Element                    ${BTN_USER_MENU}

    Wait Until Element Is Visible    ${MENU_SETTINGS}    20s
    Click Element                    ${MENU_SETTINGS}

    Wait Until Location Contains     /settings    20s
    Wait Until Page Contains         Nastavenia   20s

Open Settings Direct
    Go To    ${BASE_URL}settings
    Wait Until Location Contains    /settings    20s
    Wait Until Page Contains        Nastavenia   20s

###############################################################################
# PROFIL – Webstránka
###############################################################################

Input Website
    [Arguments]    ${website}
    Wait Until Element Is Visible    ${INPUT_WEBSITE}    20s
    Clear Element Text               ${INPUT_WEBSITE}
    Input Text                       ${INPUT_WEBSITE}    ${website}

Save Profile Changes
    Wait Until Element Is Visible    ${BTN_SAVE_CHANGES}    20s
    Scroll Element Into View         ${BTN_SAVE_CHANGES}
    Click Element                    ${BTN_SAVE_CHANGES}

###############################################################################
# PROFIL – Telefón
###############################################################################

Input Phone
    [Arguments]    ${phone}
    Wait Until Element Is Visible    ${INPUT_PHONE}    20s
    Clear Element Text               ${INPUT_PHONE}
    Input Text                       ${INPUT_PHONE}    ${phone}

Verify Phone Validation Error
    # ak validácia funguje, Angular Material typicky zobrazí mat-error
    Wait Until Page Contains Element    css=mat-error    10s
    Capture Page Screenshot

Verify Phone Was Saved Bug
    # BUG reprodukcia: žiadna chyba sa neobjaví
    ${has_error}=    Run Keyword And Return Status    Page Should Contain Element    css=mat-error
    IF    ${has_error}
        Take Screenshot On Failure    Očakával som BUG (bez chyby), ale objavil sa mat-error – správanie sa zmenilo.
    END
    Capture Page Screenshot

Verify Phone Saved
    [Arguments]    ${phone}
    [Documentation]    Refreshne nastavenia a overí, že pole Telefón obsahuje očakávané číslo.
    Reload Page
    Wait Until Page Contains    Nastavenia    15s
    Wait Until Element Is Visible    ${INPUT_PHONE}    20s
    ${value}=    Get Value    ${INPUT_PHONE}
    Should Be Equal    ${value}    ${phone}
    Capture Page Screenshot

###############################################################################
# PROFIL – Email
###############################################################################

Input Email
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${INPUT_EMAIL}    20s
    Clear Element Text               ${INPUT_EMAIL}
    Input Text                       ${INPUT_EMAIL}    ${email}

Verify Invalid Email Message
    [Documentation]    Očakáva validačnú chybu pre neplatný email.
    ${has_err}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${ERR_EMAIL}    8s
    IF    ${has_err}
        Page Should Contain Element    ${ERR_EMAIL}
    ELSE
        Take Screenshot On Failure    Očakával som validačnú chybu pre email, ale nezobrazila sa.
    END

###############################################################################
# PROFIL – Miestnosť
###############################################################################

Input Room
    [Arguments]    ${room}
    Wait Until Element Is Visible    ${INPUT_ROOM}    20s
    Clear Element Text               ${INPUT_ROOM}
    Input Text                       ${INPUT_ROOM}    ${room}

Verify Room Format Error
    [Documentation]    Očakáva validačnú chybu pri zlom formáte miestnosti.
    ${has_err}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${ERR_ROOM}    8s
    IF    ${has_err}
        Page Should Contain Element    ${ERR_ROOM}
    ELSE
        # BUG path – chyba sa nezobrazila
        Take Screenshot On Failure    Očakával som validačnú chybu pre miestnosť, ale žiadna sa nezobrazila.
    END

###############################################################################
# PROFIL – helpery
###############################################################################

Get About Me Locator
    [Documentation]    Vyberie locator pre pole "O mne" (preferuje textarea, fallback input).
    ${has_ta}=    Run Keyword And Return Status    Page Should Contain Element    ${INPUT_ABOUT_ME_TEXTAREA}
    IF    ${has_ta}
        ${locator}=    Set Variable    ${INPUT_ABOUT_ME_TEXTAREA}
    ELSE
        ${locator}=    Set Variable    ${INPUT_ABOUT_ME_INPUT}
    END
    Wait Until Element Is Visible    ${locator}    20s
    RETURN    ${locator}

Python Repr
    [Arguments]    ${text}
    ${repr}=    Evaluate    repr($text)
    RETURN    ${repr}

Set Element Value With Events
    [Documentation]    Nastaví value cez JS (podporuje non-BMP emoji) a vyvolá input/change/blur, aby Angular/Material zmenu zaregistroval.
    [Arguments]    ${locator}    ${text}
    ${xp}=    Replace String    ${locator}    xpath=    ${EMPTY}

    ${driver}=    Evaluate    __import__('robot.libraries.BuiltIn', fromlist=['BuiltIn']).BuiltIn().get_library_instance('SeleniumLibrary').driver

    ${script}=    Catenate    SEPARATOR=\n
    ...    var xp = arguments[0];
    ...    var val = arguments[1];
    ...    var el = document.evaluate(xp, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if(!el){ throw new Error('ABOUT_ME element not found for XPath: ' + xp); }
    ...    el.focus();
    ...    el.value = val;
    ...    el.dispatchEvent(new Event('input', {bubbles:true}));
    ...    el.dispatchEvent(new Event('change', {bubbles:true}));
    ...    el.dispatchEvent(new Event('blur', {bubbles:true}));

    Call Method    ${driver}    execute_script    ${script}    ${xp}    ${text}

Wait For Save To Finish
    [Documentation]    Po kliknutí na "Uložiť zmeny" čaká, kým sa UI ustáli (spinner zmizne alebo aspoň krátky stabilizačný wait).
    ${has_spinner}=    Run Keyword And Return Status    Page Should Contain Element    css=mat-progress-spinner,css=.mat-mdc-progress-spinner
    IF    ${has_spinner}
        Wait Until Page Does Not Contain Element    css=mat-progress-spinner,css=.mat-mdc-progress-spinner    20s
    ELSE
        Sleep    300ms
    END

###############################################################################
# PROFIL – O mne (Emoji)  (fix na "ChromeDriver only supports BMP")
###############################################################################

Input About Me
    [Arguments]    ${text}
    ${locator}=    Get About Me Locator
    Set Element Value With Events    ${locator}    ${text}

Verify About Me Saved
    [Arguments]    ${expected}

    Reload Page
    Wait Until Page Contains    Nastavenia    20s

    ${locator}=    Get About Me Locator
    ${xp}=    Replace String    ${locator}    xpath=    ${EMPTY}

    ${driver}=    Evaluate    __import__('robot.libraries.BuiltIn', fromlist=['BuiltIn']).BuiltIn().get_library_instance('SeleniumLibrary').driver
    ${script}=    Catenate    SEPARATOR=\n
    ...    var xp = arguments[0];
    ...    var el = document.evaluate(xp, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if(!el){ return null; }
    ...    return el.value;

    ${val}=    Call Method    ${driver}    execute_script    ${script}    ${xp}

    Should Be Equal    ${val}    ${expected}
    Capture Page Screenshot

###############################################################################
# LOGIN – články editor
###############################################################################

Login As Articles Editor
    Login Local    ${USER_ARTICLESEDITOR}    ${PASS_ARTICLESEDITOR}

###############################################################################
# ARTICLES
###############################################################################

Open First Article From Home
    [Documentation]    Otvorí prvý článok z hlavnej stránky (fallback podľa href obsahujúceho article/news).
    Open Home Page
    Wait Until Element Is Visible    ${FIRST_ARTICLE_LINK}    20s
    Click Element                    ${FIRST_ARTICLE_LINK}

Open Article Edit
    Wait Until Element Is Visible    ${BTN_EDIT_ARTICLE}    20s
    Scroll Element Into View         ${BTN_EDIT_ARTICLE}
    Click Element                    ${BTN_EDIT_ARTICLE}

Clear Article Title And Content
    Wait Until Element Is Visible    ${INPUT_ARTICLE_TITLE}    20s
    Clear Element Text               ${INPUT_ARTICLE_TITLE}
    Wait Until Element Is Visible    ${INPUT_ARTICLE_CONTENT}    20s
    Clear Element Text               ${INPUT_ARTICLE_CONTENT}

Save Article
    Wait Until Element Is Visible    ${BTN_SAVE_ARTICLE}    20s
    Scroll Element Into View         ${BTN_SAVE_ARTICLE}
    Click Element                    ${BTN_SAVE_ARTICLE}

Verify Article Empty Error
    [Documentation]    Očakáva validačnú chybu pre prázdny článok / povinné polia.
    ${has_err}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${ERR_ARTICLE_EMPTY}    8s
    IF    ${has_err}
        Page Should Contain Element    ${ERR_ARTICLE_EMPTY}
    ELSE
        Take Screenshot On Failure    Očakával som validačnú chybu pri prázdnom článku, ale nezobrazila sa.
    END

###############################################################################
# PROFIL – Webstránka / Telefón (drobné aliasy pre kompatibilitu testov)
###############################################################################

Input Website For Profile
    [Arguments]    ${website}
    Input Website    ${website}

Input Phone For Profile
    [Arguments]    ${phone}
    Input Phone    ${phone}

###############################################################################
# LOGIN – portaladmin
###############################################################################

Login As Portaladmin
    Login Local    ${USER_PORTALADMIN}    ${PASS_PORTALADMIN}

###############################################################################
# INFO WEB / SUBJECTS
###############################################################################

Open Info Web Tab
    [Documentation]    Robustne otvorí menu Informačný web (hamburger → klik na položku → čaká na podmenu subjects/employees).
    Ensure Menu Expanded
    Execute Javascript    window.scrollTo(0,0)
    ${candidates}=    Create List    ${TAB_INFOWEB_ITEM}    ${TAB_INFOWEB}    ${MENU_INFOWEB}
    FOR    ${loc}    IN    @{candidates}
        ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    4s
        IF    ${visible}
            Scroll Element Into View    ${loc}
            Click Element               ${loc}
            Sleep    300ms
            ${expanded}=    Run Keyword And Return Status    Page Should Contain Element    ${LINK_MANAGE_SUBJECTS}
            ${expanded_emp}=    Run Keyword And Return Status    Page Should Contain Element    ${LINK_MANAGE_EMPLOYEES}
            IF    ${expanded} or ${expanded_emp}
                Exit For Loop
            END
        END
    END
    Wait Until Keyword Succeeds    4x    1s    Run Keyword If    ${expanded} or ${expanded_emp}    No Operation    ELSE    Page Should Contain Element    ${LINK_MANAGE_EMPLOYEES} | ${LINK_MANAGE_SUBJECTS}

Open Manage Subjects
    [Documentation]    Klikne na Spravovať predmety a čaká na načítanie zoznamu.
    Wait Until Element Is Visible    ${LINK_MANAGE_SUBJECTS}    20s
    Scroll Element Into View         ${LINK_MANAGE_SUBJECTS}
    Click Element                    ${LINK_MANAGE_SUBJECTS}

Open Add New Subject Form
    [Documentation]    Klikne na Pridať nový predmet.
    Wait Until Element Is Visible    ${BTN_ADD_NEW_SUBJECT}    20s
    Scroll Element Into View         ${BTN_ADD_NEW_SUBJECT}
    Click Element                    ${BTN_ADD_NEW_SUBJECT}

Submit Empty Subject
    [Documentation]    Stlačí Pridať predmet bez vyplnenia polí.
    Wait Until Element Is Visible    ${BTN_SUBMIT_SUBJECT}    20s
    Scroll Element Into View         ${BTN_SUBMIT_SUBJECT}
    Click Element                    ${BTN_SUBMIT_SUBJECT}

Verify Subject Empty Fields Errors
    [Documentation]    Overí, že sa zobrazila validačná chyba na prázdne polia.
    ${has_err}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${ERR_SUBJECT_REQUIRED}    8s
    IF    ${has_err}
        Page Should Contain Element    ${ERR_SUBJECT_REQUIRED}
    ELSE
        Take Screenshot On Failure    Očakával som validačnú chybu pri prázdnych poliach predmetu, ale nezobrazila sa.
    END

###############################################################################
# INFO WEB / EMPLOYEES
###############################################################################

Open Manage Employees
    [Documentation]    Klikne na Spravovať pracovníkov a čaká na načítanie zoznamu.
    Wait Until Element Is Visible    ${LINK_MANAGE_EMPLOYEES}    20s
    Scroll Element Into View         ${LINK_MANAGE_EMPLOYEES}
    Click Element                    ${LINK_MANAGE_EMPLOYEES}

Open Add New Employee Form
    [Documentation]    Klikne na Pridať nového zamestnanca.
    Wait Until Element Is Visible    ${BTN_ADD_NEW_EMPLOYEE}    20s
    Scroll Element Into View         ${BTN_ADD_NEW_EMPLOYEE}
    Click Element                    ${BTN_ADD_NEW_EMPLOYEE}

Submit Empty Employee
    [Documentation]    Stlačí Pridať zamestnanca bez vyplnenia polí.
    Wait Until Element Is Visible    ${BTN_SUBMIT_EMPLOYEE}    20s
    Scroll Element Into View         ${BTN_SUBMIT_EMPLOYEE}
    Click Element                    ${BTN_SUBMIT_EMPLOYEE}

Verify Employee Empty Fields Errors
    [Documentation]    Overí, že sa zobrazila validačná chybu na prázdne polia pri zamestnancovi.
    ${has_err}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${ERR_EMPLOYEE_REQUIRED}    8s
    IF    ${has_err}
        Page Should Contain Element    ${ERR_EMPLOYEE_REQUIRED}
    ELSE
        Take Screenshot On Failure    Očakával som validačnú chybu pri prázdnych poliach zamestnanca, ale nezobrazila sa.
    END

Fill Employee Required Fields
    [Arguments]    ${name}    ${ldap}    ${email}
    Wait Until Element Is Visible    ${INPUT_EMP_NAME}    20s
    Clear Element Text               ${INPUT_EMP_NAME}
    Input Text                       ${INPUT_EMP_NAME}    ${name}
    Wait Until Element Is Visible    ${INPUT_EMP_LDAP}    20s
    Clear Element Text               ${INPUT_EMP_LDAP}
    Input Text                       ${INPUT_EMP_LDAP}    ${ldap}
    Wait Until Element Is Visible    ${INPUT_EMP_EMAIL}    20s
    Clear Element Text               ${INPUT_EMP_EMAIL}
    Input Text                       ${INPUT_EMP_EMAIL}    ${email}
    ${has_room}=    Run Keyword And Return Status    Page Should Contain Element    ${INPUT_EMP_ROOM}
    IF    ${has_room}
        Clear Element Text    ${INPUT_EMP_ROOM}
    END
    ${has_phone}=    Run Keyword And Return Status    Page Should Contain Element    ${INPUT_EMP_PHONE}
    IF    ${has_phone}
        Clear Element Text    ${INPUT_EMP_PHONE}
    END

Select Employee Role By Text
    [Arguments]    ${role_text}
    # Počkaj na dialóg
    Wait Until Page Contains Element    css=.mat-mdc-dialog-surface    10s
    Sleep    500ms

    # Použijem JavaScript na priame začiarknutie - Material Design checkboxy sú problematické cez Selenium
    Execute Javascript
    ...    const checkboxes = Array.from(document.querySelectorAll('mat-checkbox'));
    ...    const target = checkboxes.find(cb => cb.textContent.includes('${role_text}'));
    ...    if(target) {
    ...        target.scrollIntoView({block:'center'});
    ...        const input = target.querySelector('input[type="checkbox"]');
    ...        if(input && !input.checked) {
    ...            input.click();
    ...        }
    ...    }

    Sleep    300ms

    # Over cez JS, že je zaškrtnutý
    ${checked}=    Execute Javascript
    ...    const checkboxes = Array.from(document.querySelectorAll('mat-checkbox'));
    ...    const target = checkboxes.find(cb => cb.textContent.includes('${role_text}'));
    ...    if(target) {
    ...        const input = target.querySelector('input[type="checkbox"]');
    ...        return input ? input.checked : false;
    ...    }
    ...    return false;

    Should Be True    ${checked}    msg=Checkbox pre rolu ${role_text} nebol zaškrtnutý

Submit Employee Form
    Wait Until Element Is Visible    ${BTN_SUBMIT_EMPLOYEE}    20s
    Scroll Element Into View         ${BTN_SUBMIT_EMPLOYEE}
    Click Element                    ${BTN_SUBMIT_EMPLOYEE}

Verify Multi Role Not Allowed Error
    [Documentation]    Očakáva varovanie/validáciu pri viacerých rolách; ak nič nevidí, FAIL (BUG).
    ${err_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${ERR_EMPLOYEE_MULTIROLE}    8s
    IF    ${err_visible}
        Page Should Contain Element    ${ERR_EMPLOYEE_MULTIROLE}
    ELSE
        Capture Page Screenshot
        Fail    BUG: Viaceré roly boli povolené a žiadna validácia sa nezobrazila.
    END

Assert Role Checked
    [Arguments]    ${role_text}
    [Documentation]    Spoľahlivo overí, že rola (mat-checkbox/mat-mdc-checkbox) je zaškrtnutá. Selenium `Element Should Be Selected` býva pri Angular Material nespoľahlivé.

    # Daj UI chvíľu na dokončenie (Angular change detection po kliknutí)
    Sleep    200ms

    # SeleniumLibrary keyword `Execute Javascript` nevie odovzdať JS argumenty ako WebDriver.
    # Preto si rolu encodneme cez json.dumps do bezpečného JS string literálu.
    ${role_json}=    Evaluate    __import__('json').dumps($role_text)

    ${role_checked}=    Execute Javascript
    ...    const wanted = ${role_json};
    ...    const norm = s => (s || '').replace(/\s+/g,' ').trim();
    ...    const nodes = Array.from(document.querySelectorAll('mat-checkbox, mat-mdc-checkbox'));
    ...    const host = nodes.find(n => norm(n.textContent).includes(norm(wanted)));
    ...    if(!host){ return {found:false, checked:false, aria:null, input:null, classes:null}; }
    ...    const aria = host.getAttribute('aria-checked');
    ...    const input = host.querySelector('input[type="checkbox"]');
    ...    const inputChecked = input ? !!input.checked : null;
    ...    const cls = host.className || '';
    ...    const classChecked = /mat-(mdc-)?checkbox-checked/.test(cls) || /mat-checkbox-checked/.test(cls);
    ...    const isChecked = (aria === 'true') || (inputChecked === true) || classChecked;
    ...    return {found:true, checked:isChecked, aria:aria, input:inputChecked, classes:cls};

    Should Be True
    ...    ${role_checked}[found]
    ...    msg=Checkbox pre rolu "${role_text}" sa nenašiel.

    Should Be True
    ...    ${role_checked}[checked]
    ...    msg=Rola ${role_text} nie je zaškrtnutá (UI assert zlyhal). Debug: aria-checked=${role_checked}[aria], input.checked=${role_checked}[input], class=${role_checked}[classes]

Open First Employee From Current Employees
    [Documentation]    Otvorí prvého zamestnanca v sekcii Aktuálni zamestnanci a čaká na formulár (Uložiť zmeny).
    Wait Until Element Is Visible    ${FIRST_EMPLOYEE_ROW}    20s
    Scroll Element Into View         ${FIRST_EMPLOYEE_ROW}
    Click Element                    ${FIRST_EMPLOYEE_ROW}
    Wait Until Element Is Visible    ${BTN_SAVE_EMPLOYEE}    15s

Save Employee Changes
    Wait Until Element Is Visible    ${BTN_SAVE_EMPLOYEE}    20s
    Scroll Element Into View         ${BTN_SAVE_EMPLOYEE}
    Click Element                    ${BTN_SAVE_EMPLOYEE}

Ensure Menu Expanded
    [Documentation]    Rozbalí bočné menu (hamburger), ak ešte neexistuje tento keyword v pamäti.
    ${has_toggle}=    Run Keyword And Return Status    Page Should Contain Element    ${BTN_MENU_TOGGLE}
    IF    ${has_toggle}
        Click Element    ${BTN_MENU_TOGGLE}
        Sleep    300ms
    END

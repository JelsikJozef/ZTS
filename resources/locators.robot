*** Variables ***
# =============================================================================
# URLs
# =============================================================================
${BASE_URL}      https://uat.ki.fri.uniza.sk/
${SIGNIN_URL}    https://uat.ki.fri.uniza.sk/sign-in

# =============================================================================
# LOGIN (lokálny účet)
# =============================================================================
# tlačidlo: "Prihlásiť sa s lokálnym účtom"
${BTN_LOCAL_LOGIN}    xpath=//span[contains(@class,'ml-1') and normalize-space(.)='Prihlásiť sa s lokálnym účtom']/ancestor::button[1]

# submit: "Prihlásiť sa" (v lokálnom formulári)
${BTN_SUBMIT_LOCAL}   xpath=//button[.//span[normalize-space(.)='Prihlásiť sa'] or normalize-space(.)='Prihlásiť sa']

# field label texty (na čakanie)
${TXT_USERNAME_LABEL}    Používateľské meno
${TXT_PASSWORD_LABEL}    Heslo

# =============================================================================
# USER MENU (ikonka hore v headeri) + položka Nastavenia
# =============================================================================
# User menu button – presne ten s ikonou user-circle
${BTN_USER_MENU}    xpath=//button[contains(@class,'mat-mdc-menu-trigger') and .//mat-icon[@data-mat-icon-name='user-circle']]

# Menu item "Nastavenia" – presne podľa HTML <a mat-menu-item href="/settings">
${MENU_SETTINGS}    xpath=//a[@mat-menu-item and @href='/settings' and .//span[normalize-space(.)='Nastavenia']]

# =============================================================================
# SETTINGS / PROFIL
# =============================================================================
# input Webstránka (label "Webstránka")
${INPUT_WEBSITE}    xpath=//label[normalize-space(.)='Webstránka']/following::input[1]

# input Email (label "Email")
${INPUT_EMAIL}    xpath=//label[normalize-space(.)='Email']/following::input[1]
${ERR_EMAIL}      xpath=//label[normalize-space(.)='Email']/following::*[contains(@class,'mat-error') or self::mat-error][1]

# =============================================================================
# SETTINGS / PROFIL – Miestnosť
# =============================================================================
${INPUT_ROOM}    xpath=//label[normalize-space(.)='Miestnosť']/following::input[1]
${ERR_ROOM}      xpath=//label[normalize-space(.)='Miestnosť']/following::*[contains(@class,'mat-error') or self::mat-error][1]

# tlačidlo "Uložiť zmeny" na stránke Nastavenia
${BTN_SAVE_CHANGES}    xpath=//button[normalize-space(.)='Uložiť zmeny' or .//span[normalize-space(.)='Uložiť zmeny']]

# =============================================================================
# SETTINGS / PROFIL – Telefón
# =============================================================================
${ERR_PHONE}    xpath=//label[normalize-space(.)='Telefón']/following::*[contains(@class,'mat-error') or self::mat-error][1]
${INPUT_PHONE}    xpath=//label[normalize-space(.)='Telefón']/following::input[1]

# O mne – zober textarea priamo po nadpise/texte "O mne"
${INPUT_ABOUT_ME_TEXTAREA}    xpath=//*[normalize-space(.)='O mne']/following::textarea[1]
${INPUT_ABOUT_ME_INPUT}       xpath=//*[normalize-space(.)='O mne']/following::input[1]

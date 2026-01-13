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

# =============================================================================
# ARTICLES
# =============================================================================
${FIRST_ARTICLE_LINK}       xpath=(//a[contains(@href,'article') or contains(@href,'news')])[1]
# širší výber edit tlačidla: aria-label, mat-icon edit, text "Upraviť"/"Editovať"
${BTN_EDIT_ARTICLE}         xpath=//a[contains(@href,'/edit') and .//span[normalize-space(.)='Upraviť článok']] | //a[contains(@href,'/edit') and .//mat-icon[@data-mat-icon-name='pencil']] | //a[contains(@href,'/edit') and contains(normalize-space(.),'Upraviť článok')] | //a[@href][.//span[contains(normalize-space(.),'Upraviť')]]
${INPUT_ARTICLE_TITLE}      xpath=//input[@formcontrolname='title' or @name='title' or @id='title' or @aria-label='Názov' or @aria-label='Title'] | //label[normalize-space(.)='Názov']/following::input[1]
${INPUT_ARTICLE_CONTENT}    xpath=//textarea[@formcontrolname='content' or @name='content' or @id='content' or @aria-label='Obsah' or @aria-label='Content'] | //label[normalize-space(.)='Obsah']/following::textarea[1] | //div[contains(@class,'ql-editor')]
${BTN_SAVE_ARTICLE}         xpath=//button[.//span[normalize-space(.)='Uložiť zmeny'] or .//span[normalize-space(.)='Uložiť zmeny'] or .//span[normalize-space(.)='Odoslať'] or normalize-space(.)='Uložiť zmeny' or normalize-space(.)='Uložiť zmeny' or normalize-space(.)='Odoslať']
${ERR_ARTICLE_EMPTY}        xpath=//mat-error | //*[contains(@class,'error') or contains(@class,'alert') or contains(@class,'invalid') or contains(translate(normalize-space(.),'PRÁZDNEPPOVINNE','prázdneppovinné'),'prazdn') or contains(translate(normalize-space(.),'PRÁZDNEPPOVINNE','prázdneppovinné'),'povinn') or contains(translate(normalize-space(.),'REQUIRED','required'),'required')][1]

# =============================================================================
# INFO WEB / SUBJECTS
# =============================================================================
${TAB_INFOWEB_ITEM}        xpath=//div[contains(@class,'fuse-vertical-navigation-item')][.//span[normalize-space(.)='Informačný web']]
${TAB_INFOWEB}              xpath=//div[contains(@class,'fuse-vertical-navigation-item')][.//span[normalize-space(.)='Informačný web']]//div[contains(@class,'fuse-vertical-navigation-item-title-wrapper')]
${LINK_MANAGE_SUBJECTS}     xpath=//div[contains(@class,'fuse-vertical-navigation-item-children')]//*[self::a or self::button][.//span[contains(normalize-space(.),'Spravovať predmety')]] | //a[(contains(@href,'subject') or contains(@href,'predmet')) and (contains(normalize-space(.),'Spravovať') or contains(normalize-space(.),'predmet'))] | //button[contains(normalize-space(.),'Spravovať predmety')]
${BTN_ADD_NEW_SUBJECT}      xpath=//button[.//span[normalize-space(.)='Pridať nový predmet'] or normalize-space(.)='Pridať nový predmet'] | //a[contains(@href,'new-subject') or contains(@href,'add-subject')]
${BTN_SUBMIT_SUBJECT}       xpath=//button[.//span[normalize-space(.)='Pridať predmet'] or normalize-space(.)='Pridať predmet'] | //button[@type='submit' and contains(translate(normalize-space(.),'PRIDAT','pridat'),'pridat')]
${INPUT_SUBJECT_NAME}       xpath=//input[@formcontrolname='name' or @name='name' or @id='name' or @aria-label='Názov predmetu' or @aria-label='Názov'] | //label[normalize-space(.)='Názov']/following::input[1]
${INPUT_SUBJECT_CODE}       xpath=//input[@formcontrolname='code' or @name='code' or @id='code' or @aria-label='Kód'] | //label[normalize-space(.)='Kód']/following::input[1]
${INPUT_SUBJECT_GUARANT}    xpath=//input[@formcontrolname='guarant' or @name='guarant' or @id='guarant' or @aria-label='Garant'] | //label[normalize-space(.)='Garant']/following::input[1]
${INPUT_SUBJECT_HOURS}      xpath=//input[@formcontrolname='hours' or @name='hours' or @id='hours' or @aria-label='Počet hodín'] | //label[normalize-space(.)='Počet hodín']/following::input[1]
${ERR_SUBJECT_HOURS}       xpath=//label[normalize-space(.)='Počet hodín']/following::*[contains(@class,'mat-error') or self::mat-error][1] | //mat-error[contains(translate(normalize-space(.),'HODIN','hodin'),'hodin')]
${INPUT_SUBJECT_CREDITS}    xpath=//input[@formcontrolname='credits' or @name='credits' or @id='credits' or @aria-label='Kredity'] | //label[normalize-space(.)='Kredity']/following::input[1]
${ERR_SUBJECT_CREDITS}      xpath=//label[normalize-space(.)='Kredity']/following::*[contains(@class,'mat-error') or self::mat-error][1] | //mat-error[contains(translate(normalize-space(.),'KREDITY','kredity'),'kred')]

${ERR_SUBJECT_REQUIRED}     xpath=//mat-error | //*[contains(@class,'snack-bar') or contains(@class,'snackbar') or contains(@class,'toast') or contains(@class,'alert') or contains(@class,'error') or contains(@class,'invalid')][contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'povinn') or contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'prazd') or contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'vypln') or contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'required')][1]

# =============================================================================
# INFO WEB / EMPLOYEES
# =============================================================================
${LINK_MANAGE_EMPLOYEES}    xpath=//div[contains(@class,'fuse-vertical-navigation-item-children')]//*[self::a or self::button][.//span[contains(normalize-space(.),'Spravovať pracovníkov')]] | //a[(contains(@href,'employee') or contains(@href,'zamest')) and contains(normalize-space(.),'Spravovať')] | //button[contains(normalize-space(.),'Spravovať pracovníkov')]
${BTN_ADD_NEW_EMPLOYEE}     xpath=//button[.//span[normalize-space(.)='Pridať nového zamestnanca'] or normalize-space(.)='Pridať nového zamestnanca'] | //a[contains(@href,'new-employee') or contains(@href,'add-employee')]
${BTN_SUBMIT_EMPLOYEE}      xpath=//button[.//span[normalize-space(.)='Pridať zamestnanca'] or normalize-space(.)='Pridať zamestnanca' or @type='submit']
${ERR_EMPLOYEE_REQUIRED}    xpath=//mat-error | //*[contains(translate(normalize-space(.),'PRÁZDNEPVOVINÉ','prázdnepvoviné'),'prazdne') or contains(translate(normalize-space(.),'PRÁZDNEPVOVINÉ','prázdnepvoviné'),'povinne') or contains(translate(normalize-space(.),'REQUIRED','required'),'required')][1]
${ROLE_CHECKBOX}            xpath=//mat-checkbox[.//label[contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÄČĎÉÍĹĽŇÓÔÖŘŔŠŤÚÝŽ','abcdefghijklmnopqrstuvwxyzáäčďéíĺľňóôöřŕšťúýž'),'__ROLE_TEXT__')]]//input[@type='checkbox'] | //label[contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÄČĎÉÍĹĽŇÓÔÖŘŔŠŤÚÝŽ','abcdefghijklmnopqrstuvwxyzáäčďéíĺľňóôöřŕšťúýž'),'__ROLE_TEXT__')]/preceding::input[@type='checkbox'][1] | //label[contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÄČĎÉÍĹĽŇÓÔÖŘŔŠŤÚÝŽ','abcdefghijklmnopqrstuvwxyzáäčďéíĺľňóôöřŕšťúýž'),'__ROLE_TEXT__')]/ancestor::mat-checkbox//input[@type='checkbox']
${INPUT_EMP_NAME}           xpath=//input[@id='displayName' or @formcontrolname='name' or @name='name' or @aria-label='Zobrazované meno' or @aria-label='Meno'] | //label[contains(normalize-space(.),'Zobrazované meno') or contains(normalize-space(.),'Meno')]/following::input[1]
${INPUT_EMP_LDAP}           xpath=//input[@id='userName' or @formcontrolname='ldap' or @name='ldap' or @aria-label='LDAP'] | //label[contains(normalize-space(.),'LDAP')]/following::input[1]
${INPUT_EMP_EMAIL}          xpath=//input[@id='mail' or @formcontrolname='email' or @name='email' or @aria-label='Email'] | //label[contains(normalize-space(.),'Email')]/following::input[1]
${INPUT_EMP_ROOM}           xpath=//input[@id='roomNumber' or @formcontrolname='room' or @name='room' or @aria-label='Číslo miestnosti'] | //label[contains(normalize-space(.),'Číslo miestnosti')]/following::input[1]
${INPUT_EMP_PHONE}          xpath=//input[@id='telephoneNumber' or @formcontrolname='telephoneNumber' or @name='telephoneNumber' or @aria-label='Telefónne číslo'] | //label[contains(normalize-space(.),'Telefón')]/following::input[1]
${ERR_EMPLOYEE_MULTIROLE}   xpath=//mat-error[contains(translate(normalize-space(.),'ROLA','rola'),'rola')] | //*[contains(translate(normalize-space(.),'VIAC','viac'),'viac') and contains(translate(normalize-space(.),'ROL','rol'),'rol')] | //*[contains(translate(normalize-space(.),'JEDNU','jednu'),'jednu') and contains(translate(normalize-space(.),'RO','ro'),'ro')]

# =============================================================================
# NAVIGATION / MENU (portaladmin visibility)
# =============================================================================
${BTN_MENU_TOGGLE}         xpath=//button[contains(@class,'mat-icon-button')][.//mat-icon[@data-mat-icon-name='menu' or contains(translate(normalize-space(.),'MENU','menu'),'menu')]] | //button[@aria-label='Menu' or @aria-label='Toggle menu']
${MENU_ARTICLES}           xpath=//div[contains(@class,'fuse-vertical-navigation-item')][.//span[normalize-space(.)='Články' or normalize-space(.)='Articles']]//*[contains(@class,'fuse-vertical-navigation-item-title')][1] | //*[self::a or self::button or self::span][contains(normalize-space(.),'Články') or contains(normalize-space(.),'Articles')]
${MENU_INFOWEB}            xpath=//div[contains(@class,'fuse-vertical-navigation-item')][.//span[normalize-space(.)='Informačný web']]//div[contains(@class,'fuse-vertical-navigation-item-title-wrapper')] | //*[self::a or self::button or self::span][contains(normalize-space(.),'Informačný web')]
${MENU_TIMETABLES}         xpath=//a[@href='/timetables'] | //*[self::a or self::button or self::span][contains(normalize-space(.),'Rozvrhy')]

# =============================================================================
# LOGIN (bočná lišta)
# =============================================================================
${BTN_LOGIN_SIDEBAR}    xpath=//a[.//span[normalize-space(.)='Prihlásiť sa'] or normalize-space(.)='Prihlásiť sa' or contains(@href,'sign-in')] | //button[.//span[normalize-space(.)='Prihlásiť sa'] or normalize-space(.)='Prihlásiť sa']

${FIRST_EMPLOYEE_ROW}      xpath=(//div[contains(@class,'employees-table') and .//button[contains(@class,'hover:underline')]][1]//button[contains(@class,'hover:underline')])[1]
${BTN_SAVE_EMPLOYEE}       xpath=//button[.//span[normalize-space(.)='Uložiť zmeny'] or normalize-space(.)='Uložiť zmeny'] | //button[@type='submit' and contains(normalize-space(.),'Uložiť')]

# =============================================================================
# TIMETABLES
# =============================================================================
${LINK_TIMETABLES}        xpath=//a[@href='/timetables' or contains(@href,'/timetables') or @routerlink='/timetables' or contains(@routerlink,'timetables')] | //*[self::a or self::button or self::span][contains(normalize-space(.),'Rozvrhy') or contains(normalize-space(.),'Timetables')]
${PAGE_404_MARKER}        xpath=//*[contains(normalize-space(.),'404') or contains(normalize-space(.),'Stránka nenájdená') or contains(normalize-space(.),'Page not found')]

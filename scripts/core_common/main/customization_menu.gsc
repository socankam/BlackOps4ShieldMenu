CustomizationMenu(){
    self createMenu("CustomizationMenu", "Customizations");
    self addToggleOption("CustomizationMenu", "Enable Menu HUD (Fullscreen only)", &EnableMenuHUD, false);
    self addOption("CustomizationMenu", "Change Primary Color", &OpenSubMenu, "PrimaryColor");
    self addOption("CustomizationMenu", "Change Secondary Color", &OpenSubMenu, "SecondaryColor");
    self addOption("CustomizationMenu", "Change Scroller Icon", &OpenSubMenu, "ScrollerIcon");
    if(Multiplayer()){
        self addToggleOption("CustomizationMenu", "Enable Briefcase", &EnableBriefcase, false);
        self addToggleOption("CustomizationMenu", "Enable Sound Effects", &SoundEffects, false);
    }
    self addToggleOption("CustomizationMenu", "Background Blur", &EnableMenuBlur, false);

    self createMenu("ScrollerIcon", "Scroller Icon");
    self addOption("ScrollerIcon", "None / No Icon", &setScrollerIcon, "");
    self addOption("ScrollerIcon", "Skull", &setScrollerIcon, "^BHUD_OBIT_DEATH_SUICIDE^");
    self addOption("ScrollerIcon", "Care Package", &setScrollerIcon, "^BHUD_OBIT_CRATE^");
    self addOption("ScrollerIcon", "Knife", &setScrollerIcon, "^BHUD_OBIT_KNIFE^");
    self addOption("ScrollerIcon", "Fist", &setScrollerIcon, "^BHUD_OBIT_WEAPON_BUTT^");
    self addOption("ScrollerIcon", "White Box", &setScrollerIcon, "^BHUD_OBIT_DEATH GRENADE_ROUND^");
    self addOption("ScrollerIcon", "Death Fall", &setScrollerIcon, "^BHUD_OBIT_DEATH_FALLING^");
    self addOption("ScrollerIcon", "COD Points", &setScrollerIcon, "^BBUTTON_COD_POINT_ICON^");
    self addOption("ScrollerIcon", "Trademark / Registered", &setScrollerIcon, "^BBUTTON_REGISTERED_SYMBOL^");
    self addOption("ScrollerIcon", "Right Mouse", &setScrollerIcon, "^BBUTTON_MOUSE_RIGHT^");
    self addOption("ScrollerIcon", "Triangle (Playstation)", &setScrollerIcon, "^BPS3ButtonTriangle^");
    self addOption("ScrollerIcon", "Y Button (Xbox)", &setScrollerIcon, "^BXENONButtonY^");

    self createMenu("PrimaryColor", "Primary Color");
    self addOption("PrimaryColor", "Red", &setPrimaryColor, "^9");
    self addOption("PrimaryColor", "Green", &setPrimaryColor, "^2");
    self addOption("PrimaryColor", "Yellow", &setPrimaryColor, "^3");
    self addOption("PrimaryColor", "Blue", &setPrimaryColor, "^4");
    self addOption("PrimaryColor", "Cyan", &setPrimaryColor, "^5");
    self addOption("PrimaryColor", "Pink", &setPrimaryColor, "^6");
    self addOption("PrimaryColor", "Black", &setPrimaryColor, "^0");
    self addOption("PrimaryColor", "White", &setPrimaryColor, "^7");

    self createMenu("SecondaryColor", "Secondary");
    self addOption("SecondaryColor", "Red", &setSecondaryColor, "^9");
    self addOption("SecondaryColor", "Green", &setSecondaryColor, "^2");
    self addOption("SecondaryColor", "Yellow", &setSecondaryColor, "^3");
    self addOption("SecondaryColor", "Blue", &setSecondaryColor, "^4");
    self addOption("SecondaryColor", "Cyan", &setSecondaryColor, "^5");
    self addOption("SecondaryColor", "Pink", &setSecondaryColor, "^6");
    self addOption("SecondaryColor", "Black", &setSecondaryColor, "^0");
    self addOption("SecondaryColor", "White", &setSecondaryColor, "^7");
}

EnableMenuHUD()
{
    self.HUD = !isDefined(self.HUD) || !self.HUD;
    CloseMenu();
    if (isDefined(self.HUD) && self.HUD) self iPrintlnBold("Please set your game to fullscreen mode!");
    wait 1;
    self runMenu("Main");
}

EnableBriefcase()
{
    self.Briefcase = !isDefined(self.Briefcase) || !self.Briefcase;
    self iPrintlnBold("Setting will be applied when you re-open the menu.");
}

SoundEffects()
{
    self.SoundEffects = !isDefined(self.SoundEffects) || !self.SoundEffects;
}

EnableMenuBlur()
{
    self.MenuBlur = !isDefined(self.MenuBlur) || !self.MenuBlur;
    self iPrintlnBold("Setting will be applied when you re-open the menu.");
}

setScrollerIcon(newScrollerIcon) {
    self.icon = newScrollerIcon;
    if(self.ShieldClient){
        if(self.icon == "") self iPrintln("Scroller icon set blank");
        else self iPrintlnBold("Scroller icon set to: " + self.icon);
    }
    else{
        if(self.icon == "") self iPrintlnBold("Scroller icon set blank");
        else self iPrintlnBold("Scroller icon set to: " + self.icon);
    }
}

setPrimaryColor(newPrimaryColor) {
    self.primaryColor = newPrimaryColor;
    MenuHUDS();
    self notify("menu_closed");
    if (isDefined(self.HUD) && self.HUD) ScrollingTextHUD();
    if (isDefined(self.DVDText)){
        self notify("stop_bounce");
        self.DVDText = true;
        thread BouncingText();
    }
    if (isDefined(self.DoHeart)){
        self notify("stop_doheart");
        self.DoHeart = true;
        thread DoHeartText();
    }
}

setSecondaryColor(newSecondaryColor) {
    self.secondaryColor = newSecondaryColor;
    MenuHUDS();
    self notify("menu_closed");
    if (isDefined(self.HUD) && self.HUD) ScrollingTextHUD();
    if (isDefined(self.DVDText)){
        self notify("stop_bounce");
        self.DVDText = true;
        thread BouncingText();
    }
    if (isDefined(self.DoHeart)){
        self notify("stop_doheart");
        self.DoHeart = true;
        thread DoHeartText();
    }
}

SoundEffect(){
    if(self.SoundEffects) {
        self playsound("mpl_fracture_deposit_1");
    }
}
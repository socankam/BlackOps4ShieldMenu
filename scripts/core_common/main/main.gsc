init() {
    return true;
}

onPlayerConnect() {
    if(self isHost()) ShieldClearHudElems();
    self.Developer = "SoCanKam";

    //Every time you add a new menu to the main menu, do it here as well.
    level.MainMenuRegistry = []; //Main Menu
    level.MainMenuRegistry["Server Menu"] = &ServerMenu;
    level.MainMenuRegistry["Personal Menu"] = &PersonalMenu; // A few menus are initiated in this 1 .gsc
    level.MainMenuRegistry["Weapon Options"] = &WeaponsMenu;
    level.MainMenuRegistry["Vehicle Menu"] = &VehicleMenu;
    level.MainMenuRegistry["Zombies Menu"] = &ZombieMenu;
    level.MainMenuRegistry["Vision Menu"] = &VisionMenu;
    level.MainMenuRegistry["Teleport Menu"] = &TeleportMenu;
    level.MainMenuRegistry["Character Menu"] = &CharacterMenu;
    level.MainMenuRegistry["Forge Menu"] = &ForgeMenu;
    level.MainMenuRegistry["All Players Menu"] = &AllPlayersMenu;
    level.MainMenuRegistry["Account Menu"] = &AccountMenu;
    level.MainMenuRegistry["Customization Menu"] = &CustomizationMenu;
    level.MainMenuRegistry["Dev Menu"] = &DevMenu;

    // For Custom zombies
    level.MainMenuRegistry["Buy Station"] = &BuyStation;
    level.MainMenuRegistry["Cheat Menu"] = &CheatMenu;

    self.primaryColor = "^3";
    self.secondaryColor = "^5";
    self.icon = "";

    if(self isHost()){ self.ShieldClient = true; // Still working on this
    }
    return true;
}

onPlayerSpawned() {
    self endon("disconnect", "spawned_player");
    level endon("end_game", "game_ended");

    self.menu = undefined;

    for (i = 0; i < 75; i++) {
        self iprintln("");
    }

    self iPrintlnBold(self.primaryColor + "Crouch and then press the grenade button to open the menu.");

    self thread initializeMenu();
    self thread setupMenu();
    self thread monitorMenuInput();
    if(self isHost()) thread monitorDeath();
}

monitorDeath()
{
    self endon("disconnect");
    while (true)
    {
        self waittill("death");

        if (isDefined(self.noclip_on) && self.noclip_on)
        {
            self NoClip_Stop();

            if (isDefined(self.menu) && isDefined(self.menu["dynamicVars"]))
            {
                self.menu["dynamicVars"]["NoClip"] = false;
            }
        }

        if (isDefined(self.menu) && self.menu["menuIsOpen"])
        {
            ClearMenuHUDs();
            self CloseMenu();
        }
    }
}

initializeMenu() {
    if (!isDefined(self.menu)) {
        self.menu = [];
        self.menu["items"] = [];
        self.menu["menuParent"] = [];
        self.menu["currentIndex"] = 0;
        self.menu["menuIsOpen"] = false;
    }
}

runMenu(menuKey) {
    if (!isDefined(menuKey)) menuKey = "Main";
    if (!isDefined(self.menu["items"][menuKey])) {
        return;
    }

    if (self.menu["items"][menuKey]["menuIsOpen"]) {
        return;
    }

    if (isDefined(self.menu["currentMenu"]) && isDefined(self.menu["items"][self.menu["currentMenu"]])) {
        prevMenu = self.menu["currentMenu"];
        self.menu["items"][prevMenu]["menuIsOpen"] = false;

        if (!isDefined(self.menu["items"][menuKey]["parentMenu"])) {
            self.menu["items"][menuKey]["parentMenu"] = prevMenu;
        }
    }

    self.menu["items"][menuKey]["menuIsOpen"] = true;
    self.menu["currentMenu"] = menuKey;
    self.menu["currentIndex"] = 0;

    menu = self.menu["items"][menuKey];
    menu["startIndex"] = 0;
    menu["endIndex"] = 8;

    refreshMenuDisplay(menuKey);

    wait 0.1;
    refreshMenuDisplay(menuKey);

    while (self.menu["items"][menuKey]["menuIsOpen"]) {
        if (self AttackButtonPressed()) {
            if (isDefined(self.SoundEffects) && Multiplayer()) {
                SoundEffect();
            }
            self.menu["currentIndex"]++;
            if (self.menu["currentIndex"] >= menu["options"].size) {
                self.menu["currentIndex"] = 0;
            }
            refreshMenuDisplay(menuKey);

            while (self AttackButtonPressed()) wait 0.05;
        } 
        else if (self ADSButtonPressed()) {
            if (isDefined(self.SoundEffects) && Multiplayer()) {
                SoundEffect();
            }
            self.menu["currentIndex"]--;
            if (self.menu["currentIndex"] < 0) {
                self.menu["currentIndex"] = menu["options"].size - 1;
            }
            refreshMenuDisplay(menuKey);

            while (self ADSButtonPressed()) wait 0.05;
        } 
        else if (self MeleeButtonPressed() || self StanceButtonPressed()) {
            if (self.menu["currentMenu"] == "Main" || isDefined(self.customzombies)) {
                self CloseMenu();
                return;
            } else {
                if (isDefined(self.menu["items"][self.menu["currentMenu"]]["parentMenu"])) {
                    parentMenu = self.menu["items"][self.menu["currentMenu"]]["parentMenu"];

                    self.menu["items"][self.menu["currentMenu"]]["menuIsOpen"] = false;
                    self.menu["items"][self.menu["currentMenu"]]["parentMenu"] = undefined;

                    self runMenu(parentMenu);
                    return;
                }
            }

            while (self MeleeButtonPressed() || self StanceButtonPressed()) wait 0.05;
        } 
        else if (self UseButtonPressed()) {
            if (self.menu["currentIndex"] < menu["options"].size) {
                selectedOption = menu["options"][self.menu["currentIndex"]];

                if (isDefined(selectedOption[3])) {
                    self toggleBoolOption(menuKey);
                } else {
                    selectOption(menuKey);
                }
                refreshMenuDisplay(menuKey);

                while (self UseButtonPressed()) wait 0.05;
            }
        }

        wait 0.01;
    }
}

refreshMenuDisplay(menuKey) {
    if (!isDefined(self.menu["items"][menuKey]) || !self.menu["items"][menuKey]["menuIsOpen"]) {
        return;
    }

    menu = self.menu["items"][menuKey];

    if (self.ShieldClient){
        ClearMenuHUDs();
        MenuHUDS();

        numOptions = menu["options"].size;
        itemsPerPage = 20;
        totalPages = int((numOptions + itemsPerPage - 1) / itemsPerPage);
        currentPage = int(self.menu["currentIndex"] / itemsPerPage) + 1;
        startIndex = (currentPage - 1) * itemsPerPage;
        endIndex = startIndex + itemsPerPage;

        if (endIndex > numOptions) endIndex = numOptions;

    for (i = startIndex; i < endIndex; i++) {
        option = menu["options"][i];
        str = self.primaryColor + option[0];

        if (isDefined(option[3])) {
            str = str + " " + option[3];
        }

        fontSize = 0.5;

        if (i == self.menu["currentIndex"]) {
            if (self.icon == "") str = self.secondaryColor + "-> [ " + str + self.secondaryColor + " ] <-";
            else str = self.secondaryColor + self.icon + " [ " + str + self.secondaryColor + " ] " + self.icon;
            
            fontSize = 0.6;
        }

        hudElemName = "MenuLine" + i;

        ShieldRegisterHudElem(
            hudElemName,
            "",
            0xFFFFC0EB,
            self.Left, self.Top + 300,
            2, 1,
            1, 1,
            fontSize
        );

        ShieldHudElemSetText(hudElemName, str);
        self.Top += self.tsize;
    }

        ShieldRegisterHudElem(
            #"Footer",
            "",
            0xFFFFC0EB,
            -875 - 400, 67 + 300,
            2, 1,
            1, 1,
            0.5
        );
        if (isDefined(self.HUD) && self.HUD) ShieldHudElemSetText(#"Header", self.primaryColor + "Current Menu: " + self.secondaryColor + menu["title"]);
        else ShieldHudElemSetText(#"Header", self.primaryColor + "Current Menu: " + self.secondaryColor + menu["title"] + self.primaryColor + " | Page (" + currentPage + " of " + totalPages + ")");
        if (isDefined(self.HUD) && self.HUD) ShieldHudElemSetText(#"Footer", self.primaryColor + "Page (" + currentPage + " of " + totalPages + ") | " + self.secondaryColor + "Shield Menu" + self.primaryColor + " | ");
        else ShieldHudElemSetText(#"Footer", "");
    }
    else {
        if (!isDefined(menu["screenCleared"]) || !menu["screenCleared"]) {
            for (i = 0; i < 9; i++) {
                self iPrintln("");
            }
            menu["screenCleared"] = true;
        }

        self iPrintln(self.secondaryColor + " ( " + self.secondaryColor + "Current Menu - " + self.primaryColor + menu["title"] + self.secondaryColor + " )");

        numOptions = menu["options"].size;
        itemsPerPage = 7;
        totalPages = int((numOptions + itemsPerPage - 1) / itemsPerPage);
        currentPage = int(self.menu["currentIndex"] / itemsPerPage) + 1;
        startIndex = (currentPage - 1) * itemsPerPage;
        endIndex = startIndex + itemsPerPage;

        if (endIndex > numOptions) endIndex = numOptions;

        for (i = startIndex; i < endIndex; i++) {
            option = menu["options"][i];
            str = option[0];

            if (isDefined(option[3])) {
                str = str + " " + option[3];
            }

            if (i == self.menu["currentIndex"]) {
                if(self.icon != "") str = self.icon + self.secondaryColor + " [ " + self.primaryColor + str + self.secondaryColor + " ] " + self.icon;
                else str = self.secondaryColor + " [ " + self.primaryColor + str + self.secondaryColor + " ] ";
            }

            self iPrintln(str);
        }

        self iprintln(self.primaryColor + "Page [" + currentPage + " of " + totalPages + "] - ( ^BXENONButtonStickAnimatedR^ / ^BHUD_OBIT_KNIFE^ = Back )");

        remainingLines = 8 - (endIndex - startIndex + 1);
        for (i = 0; i < remainingLines; i++) {
            self iPrintln("");
        }
    }
}

CallFunction(function, params) {
    if (!isDefined(function))
        return;

    if (isString(params)) {
        return self thread [[function]](params);
    }

    numParams = params.size;
    if (numParams >= 6) {
        return self thread [[function]](params[0], params[1], params[2], params[3], params[4], params[5]);
    } else if (numParams >= 5) {
        return self thread [[function]](params[0], params[1], params[2], params[3], params[4]);
    } else if (numParams >= 4) {
        return self thread [[function]](params[0], params[1], params[2], params[3]);
    } else if (numParams >= 3) {
        return self thread [[function]](params[0], params[1], params[2]);
    } else if (numParams >= 2) {
        return self thread [[function]](params[0], params[1]);
    } else if (numParams >= 1) {
        return self thread [[function]](params[0]);
    }

    return self thread [[function]]();
}

selectOption(menuKey) {
    menu = self.menu["items"][menuKey];
    selectedOption = menu["options"][self.menu["currentIndex"]];

    if (isDefined(selectedOption[1])) {
        func = selectedOption[1];
        params = selectedOption[2];

        CallFunction(func, params);
    }
}

monitorMenuInput() {
    self endon("disconnect");

    while (true) {
        if(self getStance() == "crouch" && self FragButtonPressed()){
            if (!isDefined(self.menu["items"]["Main"]["menuIsOpen"]) || !self.menu["items"]["Main"]["menuIsOpen"]) {
                SetDvar( "cg_drawCrosshair", 0 );
                if (isDefined(self.HUD) && self.HUD) thread ScrollingTextHUD();
                ShieldRemoveHudElem("ScrollingText");
                if(isDefined(self.MenuBlur) && self.MenuBlur) self SetBlur(13, .01);
                if(isDefined(self.Briefcase) && self.Briefcase){
                    self.savedWeapon = self getCurrentWeapon();
                    self giveWeapon(getWeapon("briefcase_bomb_defuse"));
                    wait 0.1;
                    self switchToWeapon(getWeapon("briefcase_bomb_defuse"));
                }
                self.menu["currentIndex"] = 0;
            if (isDefined(self.customzombies) && self.customzombies) self runMenu("ServerMenu");
            else self runMenu("Main");
            }
        }
        wait 0.2;
    }
}

createMenu(menuKey, title) {
    if (!isDefined(self.menu["items"][menuKey])) {
        self.menu["items"][menuKey] = [];
        self.menu["items"][menuKey]["title"] = title;
        self.menu["items"][menuKey]["options"] = [];
        self.menu["items"][menuKey]["menuIsOpen"] = false;
    }
}

addToggleOption(menuKey, name, func, initialState) {
    if (!isDefined(self.menu["items"][menuKey])) {
        return;
    }

    menu = self.menu["items"][menuKey];
    count = menu["options"].size;

    if (!isDefined(self.menu["dynamicVars"])) {
        self.menu["dynamicVars"] = [];
    }

    if (isDefined(self.menu["dynamicVars"][name])) {
        initialState = self.menu["dynamicVars"][name];
    } else {
        self.menu["dynamicVars"][name] = initialState;
    }

    menu["options"][count] = [];
    menu["options"][count][0] = name;
    menu["options"][count][1] = func;
    menu["options"][count][2] = undefined;
    
    menu["options"][count][3] = initialState ? "^2[ON]" : "^1[OFF]";
    menu["options"][count][4] = initialState;
}
toggleBoolOption(menuKey) {
    menu = self.menu["items"][menuKey];
    if (!isDefined(menu)) {
        return;
    }

    selectedOption = menu["options"][self.menu["currentIndex"]];
    if (!isDefined(selectedOption) || !isDefined(selectedOption[4])) {
        return;
    }

    optionName = selectedOption[0];
    if (!isDefined(optionName)) {
        return;
    }

    if (!isDefined(self.menu["dynamicVars"])) {
        self.menu["dynamicVars"] = [];
    }

    if (!isDefined(self.menu["dynamicVars"][optionName])) {
        self.menu["dynamicVars"][optionName] = selectedOption[4];
    }

    self.menu["dynamicVars"][optionName] = !self.menu["dynamicVars"][optionName];

    selectedOption[4] = self.menu["dynamicVars"][optionName];
    selectedOption[3] = selectedOption[4] ? "^2[ON]" : "^1[OFF]";

    if (isDefined(selectedOption[1])) {
        func = selectedOption[1];
        self thread [[func]]();
    }

    refreshMenuDisplay(menuKey);
}

addOption(menuKey, name, func, params) {
    if (!isDefined(self.menu["items"][menuKey])) {
        return;
    }
    menu = self.menu["items"][menuKey];
    option = [];
    option[0] = name;
    option[1] = func;
    option[2] = params;
    menu["options"][menu["options"].size] = option;
}

setupMenu() {
    if (!isDefined(self.menu)) {
        self thread initializeMenu();
    } else {
         self.menu["items"] = [];
    }

    self createMenu("Main", "Main Menu");
    if(self isHost()) self addOption("Main", "Server Menu", &OpenSubMenu, "ServerMenu");
    if(Zombies()) self addOption("Main", "Account Menu", &OpenSubMenu, "AccountMenu");
    if (!isDefined(self.customzombies)){
        self addOption("Main", "Basic Mods Menu", &OpenSubMenu, "PersonalOptions");
        self addOption("Main", "Fun Options Menu", &OpenSubMenu, "FunOptions");
        if(Multiplayer()){
            self addOption("Main", "Specialist Menu", &OpenSubMenu, "SpecialistMenu");
            self addOption("Main", "Scorestreak Menu", &OpenSubMenu, "KillstreaksMenu");
        }
        self addOption("Main", "Weapons Menu", &OpenSubMenu, "WeaponOptions");
        self addOption("Main", "Character Menu", &OpenSubMenu, "CharacterMenu");
        self addOption("Main", "Vehicle Menu", &OpenSubMenu, "VehicleMenu");
        if(Zombies() || Blackout()) self addOption("Main", "Zombies Menu", &OpenSubMenu, "ZombieMenu");
        self addOption("Main", "Vision Menu", &OpenSubMenu, "VisionMenu");
        self addOption("Main", "Teleport Menu", &OpenSubMenu, "TeleportMenu");
        self addOption("Main", "Forge Menu", &OpenSubMenu, "ForgeMenu");
        if(Blackout()){
            self addOption("Main", "Armor Menu", &OpenSubMenu, "ArmorMenu");
        }
        self addOption("Main", "Perk Menu", &OpenSubMenu, "PerkMenu");
        self addOption("Main", "All Players Menu", &OpenSubMenu, "AllPlayersMenu");
        self addOption("Main", "Configuration Menu", &OpenSubMenu, "CustomizationMenu");
        self addOption("Main", "Dev Menu", &OpenSubMenu, "DevMenu");
    }

    foreach (menuKey, initFunction in level.MainMenuRegistry) {
        self thread [[initFunction]]();
    }
}

OpenSubMenu(menuKey) {
    if (!isDefined(self.menu["items"][menuKey])) {
        return;
    }
    self runMenu(menuKey);

    refreshMenuDisplay(menuKey);
}

CloseMenu() {
    self notify("menu_closed");

    SetDvar( "cg_drawCrosshair", 1 );
    if (isDefined(self.savedWeapon)) {
        self giveWeapon(self.savedWeapon);
        wait 0.1;
        self switchToWeapon(self.savedWeapon);
        self.savedWeapon = undefined;
    }
    if(self isHost()){
        ClearMenuHUDs();
    }
    self SetBlur(0, .01);

    self EnableWeapons();
    self EnableOffHandWeapons();
    for (i = 0; i < 9; i++) {
        self iPrintln("");
    }

    self.menu["currentMenu"] = "";
    self.menu["currentIndex"] = 0;

    foreach (key, menu in self.menu["items"]) {
        menu["menuIsOpen"] = false;
        menu["parentMenu"] = undefined;
        menu["screenCleared"] = false;
    }
}

GoBack(parentMenu) {
    self runMenu(parentMenu);
}
//Thanks to ATE for the camo values, etc.
WeaponsMenu(){
    InitWeapons();

    self createMenu("WeaponOptions", "Weapons Menu");
    self addToggleOption("WeaponOptions", "Flashing / Disco Camo", &RainbowCamo, false);
    self addOption("WeaponOptions", "Give Weapon", &OpenSubMenu, "WeaponsMenu");
    self addOption("WeaponOptions", "Camo Menu", &OpenSubMenu, "CamoMenu");
    self addOption("WeaponOptions", "Ammo Modifier Menu", &OpenSubMenu, "AmmoModifications");
    
    self createMenu("AmmoModifications", "Ammo Mods");
    self addToggleOption("AmmoModifications", "Enable Ammo Mod", &AmmoModifier, false);
    self addOption("AmmoModifications", "Shoot Rockets", &SetAmmoMod, "launcher_standard_t8");
    self addOption("AmmoModifications", "Shoot Raygun Ammo", &SetAmmoMod, "ray_gun");
    self addOption("AmmoModifications", "Shoot Paladin HB50 Ammo", &SetAmmoMod, "sniper_powerbolt_t8");
    self addOption("AmmoModifications", "Shoot MOG 12 Ammo", &SetAmmoMod, "shotgun_pump_t8");
    self addOption("AmmoModifications", "Shoot Vendetta Ammo", &SetAmmoMod, "sniper_mini14_t8");
    if(Blackout())
    {
        self addOption("AmmoModifications", "Shoot Savage Impaler Ammo", &SetAmmoMod, "ww_crossbow_impaler_t8");
        self addOption("AmmoModifications", "Shoot Blundergat Ammo", &SetAmmoMod, "ww_blundergat_t8");
    }
    if (level.CurrentMap == "wz_escape" || level.CurrentMap == "wz_escape_alt"){
        self addOption("AmmoModifications", "Shoot Raygun MK2 Ammo", &SetAmmoMod, "ray_gun_mk2");
        self addOption("AmmoModifications", "Shoot Raygun MK2 X Ammo", &SetAmmoMod, "ray_gun_mk2x");
        self addOption("AmmoModifications", "Shoot Raygun MK2 Y Ammo", &SetAmmoMod, "ray_gun_mk2y");
        self addOption("AmmoModifications", "Shoot Raygun MK2 Z Ammo", &SetAmmoMod, "ray_gun_mk2z");
        
    }

    self createMenu("WeaponsMenu", "Give Weapon");
    if(Blackout()) self addOption("WeaponsMenu", "Operator Mod Weapons", &OpenSubMenu, "OperatorMods");
    self addOption("WeaponsMenu", "Special Weapons", &OpenSubMenu, "SpecialWeapons");
    self addOption("WeaponsMenu", "Assault Rifles", &OpenSubMenu, "AssaultRifles");
    self addOption("WeaponsMenu", "SMGs", &OpenSubMenu, "SubMachineGuns");
    self addOption("WeaponsMenu", "Tactical Rifles", &OpenSubMenu, "TacticalRifles");
    self addOption("WeaponsMenu", "Snipers", &OpenSubMenu, "SniperRifles");
    self addOption("WeaponsMenu", "Shotguns", &OpenSubMenu, "Shotguns");
    self addOption("WeaponsMenu", "LMGs", &OpenSubMenu, "LightMachineGuns");
    self addOption("WeaponsMenu", "Pistols", &OpenSubMenu, "Pistols");
    self addOption("WeaponsMenu", "Melee Weapons", &OpenSubMenu, "Melee");

    BuildWeaponMenu("AssaultRifles", "Assault Rifles", level.AssaultRifleNames, level.AssaultRifles);
    BuildWeaponMenu("SubMachineGuns", "SMGs", level.SubMachineGunNames, level.SubMachineGuns);
    BuildWeaponMenu("TacticalRifles", "Tactical Rifles", level.TacticalRifleNames, level.TacticalRifles);
    BuildWeaponMenu("LightMachineGuns", "LMGs", level.LightMachineGunNames, level.LightMachineGuns);
    BuildWeaponMenu("Shotguns", "Shotguns", level.ShotgunNames, level.Shotguns);
    BuildWeaponMenu("SniperRifles", "Sniper Rifles", level.SniperRifleNames, level.SniperRifles);
    BuildWeaponMenu("Pistols", "Pistols", level.PistolNames, level.Pistols);
    if(Blackout() || Multiplayer()) BuildWeaponMenu("Melee", "Melee Weapons", level.MeleeNames, level.MeleeWeapons);

    self createMenu("SpecialWeapons", "Special Weapons");
    self addOption("SpecialWeapons", "Raygun Varients", &OpenSubMenu, "Rayguns");
    self addOption("SpecialWeapons", "Other Wonder Weapons", &OpenSubMenu, "WonderWeapons");
    if(Blackout()){
        self addOption("SpecialWeapons", "Give Basketball", &GivePlayerWeapon, "basketball");
    }

    self createMenu("OperatorMods", "Operator Mod Weapons");
    self addOption("OperatorMods", "Give VAPR-XKG Operator", &GivePlayerWeapon, "ar_stealth_t8_operator");
    self addOption("OperatorMods", "Give Tigershark Operator", &GivePlayerWeapon, "lmg_stealth_t8_operator");
    self addOption("OperatorMods", "Give GKS Operator", &GivePlayerWeapon, "smg_accurate_t8_operator");

    self createMenu("Rayguns", "Raygun Varients");
    if(Blackout() || Multiplayer())  self addOption("Rayguns", "Give Raygun", &GivePlayerWeapon, "ray_gun");
    if (level.CurrentMap == "wz_escape" || level.CurrentMap == "wz_escape_alt"){
        self addOption("Rayguns", "Give Raygun MK2", &GivePlayerWeapon, "ray_gun_mk2");
        self addOption("Rayguns", "Give Raygun MK2 X", &GivePlayerWeapon, "ray_gun_mk2x");
        self addOption("Rayguns", "Give Raygun MK2 Y", &GivePlayerWeapon, "ray_gun_mk2y");
        self addOption("Rayguns", "Give Raygun MK2 Z", &GivePlayerWeapon, "ray_gun_mk2z");
    }

    self createMenu("WonderWeapons", "Wonder Weapons");
    if (level.CurrentMap == "wz_escape" || level.CurrentMap == "wz_escape_alt"){
        //
    }
    if(Blackout())
    {
        self addOption("WonderWeapons", "Blundergat", &GivePlayerWeapon, "ww_blundergat_t8");
        self addOption("WonderWeapons", "Savage Impaler", &GivePlayerWeapon, "ww_crossbow_impaler_t8");
    }

    self createMenu("CamoMenu", "Camo Menu");
    self addOption("CamoMenu", "Mastery Camos", &OpenSubMenu, "MasteryCamos");
    self addOption("CamoMenu", "Pack-A-Punch Camos", &OpenSubMenu, "PAPCamos");
    self addOption("CamoMenu", "Reactive Camos", &OpenSubMenu, "ReactiveCamos");

    self createMenu("MasteryCamos", "Mastery Camos");
    self addOption("MasteryCamos", "Apply Gold Camo", &ApplyCamo, "43");
    self addOption("MasteryCamos", "Apply Diamond Camo", &ApplyCamo, "44");
    self addOption("MasteryCamos", "Apply Dark Matter Camo", &ApplyCamo, "45");
    self addOption("MasteryCamos", "Apply Diamond Camo (Last tier)", &ApplyCamo, "199");
    self addOption("MasteryCamos", "Apply Dark Matter Camo (Last tier)", &ApplyCamo, "192");

    self createMenu("PAPCamos", "P.A.P Camos");
    self addOption("PAPCamos", "Voyage Of Despair Purple Camo", &ApplyCamo, "146");
    self addOption("PAPCamos", "Voyage Of Despair Red Camo", &ApplyCamo, "147");
    self addOption("PAPCamos", "Voyage Of Despair Green Camo", &ApplyCamo, "148");
    self addOption("PAPCamos", "Voyage Of Despair Yellow Camo", &ApplyCamo, "149");
    self addOption("PAPCamos", "Voyage Of Despair Pink Camo", &ApplyCamo, "150");
    self addOption("PAPCamos", "IX Blue Camo", &ApplyCamo, "151");
    self addOption("PAPCamos", "IX Red Camo", &ApplyCamo, "152");
    self addOption("PAPCamos", "IX Green Camo", &ApplyCamo, "153");
    self addOption("PAPCamos", "IX Purple Camo", &ApplyCamo, "154");
    self addOption("PAPCamos", "IX Orange Camo", &ApplyCamo, "155");
    self addOption("PAPCamos", "Blood Of The Dead Yellow Camo", &ApplyCamo, "156");
    self addOption("PAPCamos", "Blood Of The Dead Red Camo", &ApplyCamo, "157");
    self addOption("PAPCamos", "Blood Of The Dead Green Camo", &ApplyCamo, "159");
    self addOption("PAPCamos", "Blood Of The Dead Purple Camo", &ApplyCamo, "160");
    self addOption("PAPCamos", "Classified 1 Camo", &ApplyCamo, "161");
    self addOption("PAPCamos", "Classified 2 Camo", &ApplyCamo, "162");
    self addOption("PAPCamos", "Classified 3 Camo", &ApplyCamo, "163");
    self addOption("PAPCamos", "Classified 4 Camo", &ApplyCamo, "164");
    self addOption("PAPCamos", "Classified 5 Camo", &ApplyCamo, "165");
    self addOption("PAPCamos", "Dead Of The Night Green Camo", &ApplyCamo, "280");
    self addOption("PAPCamos", "Dead Of The Night Purple Camo", &ApplyCamo, "281");
    self addOption("PAPCamos", "Dead Of The Night Red Camo", &ApplyCamo, "282");
    self addOption("PAPCamos", "Dead Of The Night Blue Camo", &ApplyCamo, "283");
    self addOption("PAPCamos", "Dead Of The Night Orange Camo", &ApplyCamo, "284");
    self addOption("PAPCamos", "Ancient Evil Purple Camo", &ApplyCamo, "74");
    self addOption("PAPCamos", "Ancient Evil Blue Camo", &ApplyCamo, "75");
    self addOption("PAPCamos", "Ancient Evil Orange Camo", &ApplyCamo, "76");
    self addOption("PAPCamos", "Ancient Evil Yellow Camo", &ApplyCamo, "77");
    self addOption("PAPCamos", "Ancient Evil Green Camo", &ApplyCamo, "78");

    self createMenu("ReactiveCamos", "Reactive Camos");
    self addOption("ReactiveCamos", "Apply D-Day Camo", &ApplyCamo, "298");
    self addOption("ReactiveCamos", "Apply Roadtrip Camo", &ApplyCamo, "300");
    self addOption("ReactiveCamos", "Apply Masked Camo", &ApplyCamo, "310");
    self addOption("ReactiveCamos", "Apply Bobine Camo", &ApplyCamo, "52");
    self addOption("ReactiveCamos", "Apply Search Camo", &ApplyCamo, "57");
    self addOption("ReactiveCamos", "Apply Strip Camo", &ApplyCamo, "62");
    self addOption("ReactiveCamos", "Apply Rave Camo", &ApplyCamo, "67");
    self addOption("ReactiveCamos", "Apply Nebula Camo", &ApplyCamo, "89");
    self addOption("ReactiveCamos", "Apply Roadtrip Camo", &ApplyCamo, "300");
    self addOption("ReactiveCamos", "Apply After Life Camo", &ApplyCamo, "90");
    self addOption("ReactiveCamos", "Apply Roadtrip Camo", &ApplyCamo, "300");
    self addOption("ReactiveCamos", "Apply Postluminescence Camo", &ApplyCamo, "119");
    self addOption("ReactiveCamos", "Apply 115 Camo", &ApplyCamo, "129");
    self addOption("ReactiveCamos", "Apply Grey Matter Camo", &ApplyCamo, "131");
    self addOption("ReactiveCamos", "Apply Denied Access (Waifu) Camo", &ApplyCamo, "167");
    self addOption("ReactiveCamos", "Apply Skull Camo", &ApplyCamo, "168");
    self addOption("ReactiveCamos", "Apply Solar Eruption Camo", &ApplyCamo, "381");
    self addOption("ReactiveCamos", "Apply Vision Of The Future Camo", &ApplyCamo, "387");
    self addOption("ReactiveCamos", "Apply Pestilence Camo", &ApplyCamo, "389");
    self addOption("ReactiveCamos", "Apply Crypted Camo", &ApplyCamo, "286");
    self addOption("ReactiveCamos", "Apply Judas Camo", &ApplyCamo, "357");
    self addOption("ReactiveCamos", "Apply Incandescent Camo", &ApplyCamo, "359");
    self addOption("ReactiveCamos", "Apply Encoded Camo", &ApplyCamo, "363");
}

BuildWeaponMenu(menu, title, names, weapons)
{
    self createMenu(menu, title);

    for(i = 0; i < weapons.size; i++)
        self addOption(menu, "Give " + names[i], &GivePlayerWeapon, weapons[i]);
}

InitWeapons(){
        level.AssaultRifles = StrTok(
        "ar_accurate_t8,ar_fastfire_t8,ar_an94_t8,ar_peacekeeper_t8,ar_doublebarrel_t8,ar_damage_t8,ar_stealth_t8,ar_modular_t8,ar_standard_t8,ar_galil_t8",
        ","
    );
    level.AssaultRifleNames = StrTok(
        "ICR-7,Maddox RFB,AN-94,Peacekeeper,Echohawk,Rampart 17,Vapr-XKG,KN-57,Swat RFT,Grav",
        ","
    );
    level.SubMachineGuns = StrTok(
    "smg_vmp_t8,smg_minigun_t8,smg_standard_t8,smg_handling_t8,smg_fastfire_t8,smg_capacity_t8,smg_accurate_t8,smg_fastburst_t8,smg_folding_t8",
    ","
    );
    level.SubMachineGunNames = StrTok(
        "VMP,MicroMG,MX9,Saug 9mm,Spitfire,Cordite,GKS,Daemon 3XB,Switchblade X9",
        ","
    );
    level.TacticalRifles = StrTok(
    "tr_powersemi_t8,tr_longburst_t8,tr_midburst_t8,tr_flechette_t8,tr_damageburst_t8",
    ","
    );
    level.TacticalRifleNames = StrTok(
        "Auger DMR,Swordfish,ABR .223,S6 Stingray,M16",
        ","
    );
    level.LightMachineGuns = StrTok(
        "lmg_spray_t8,lmg_stealth_t8,lmg_standard_t8,lmg_heavy_t8",
        ","
    );
    level.LightMachineGunNames = StrTok(
        "Hades,Tigershark,Titan,VKM 750",
        ","
    );
    level.Shotguns = StrTok(
        "shotgun_pump_t8,shotgun_semiauto_t8,shotgun_fullauto_t8,shotgun_precision_t8",
        ","
    );
    level.ShotgunNames = StrTok(
        "MOG 12,SG12,Rampage,Argus",
        ","
    );
    level.SniperRifles = StrTok(
        "sniper_powerbolt_t8,sniper_damagesemi_t8,sniper_locus_t8,sniper_mini14_t8,sniper_quickscope_t8,sniper_fastrechamber_t8,sniper_powersemi_t8",
        ","
    );
    level.SniperRifleNames = StrTok(
        "Paladin HB50,Havelina AA50,Locus,Vendetta,Koshka,Outlaw,SDM",
        ","
    );
    level.Pistols = StrTok(
        "pistol_standard_t8,pistol_fullauto_t8,pistol_burst_t8,pistol_revolver_t8",
        ","
    );
    level.PistolNames = StrTok(
        "Strife,KAP-45,RK 7 Garrison,Mozu",
        ","
    );
    level.MeleeWeapons = StrTok(
        "melee_coinbag_t8,melee_cutlass_t8,melee_club_t8,melee_actionfigure_t8,melee_amuletfist_t8,melee_zombiearm_t8,melee_stopsign_t8,melee_slaybell_t8,melee_secretsanta_t8,melee_demohammer_t8",
        ","
    );
    level.MeleeNames = StrTok(
        "Cha-Ching,Rising Tide,Nifo'oti,Series 6 Outrider,Eye of Apophis,Backhander,Full Stop,Slay Bell,Secret Santa,Home Wrecker",
        ","
    );
}

GivePlayerWeapon(Weapon)
{
    if(Blackout() && isDefined(self.customzombies))
    {
        if(self.points >= 2500)
        {
            self.points -= 2500;
            self giveWeapon(getWeapon(Weapon));
            wait .1;
            self giveMaxAmmo(getWeapon(Weapon));
            wait .1;
            self switchToWeapon(getWeapon(Weapon));
            self SetWeaponAmmoClip(self GetCurrentWeapon(), self GetCurrentWeapon().clipsize);
        }
        else
        {
            self iPrintLnBold("Not enough points!");
        }
    }
    else
    {
        self giveWeapon(getWeapon(Weapon));
        wait .1;
        self giveMaxAmmo(getWeapon(Weapon));
        wait .1;
        self switchToWeapon(getWeapon(Weapon));
        self SetWeaponAmmoClip(self GetCurrentWeapon(), self GetCurrentWeapon().clipsize);
    }
}

ApplyCamo(Camo) 
{
    Weapon = self getcurrentweapon();
    self setcamo(Weapon, Int(Camo));
} 

AmmoModifier()
{
    self.AmmoModifier = isDefined(self.AmmoModifier) ? undefined : true;
 
    if(isDefined(self.AmmoModifier))
    {
        self endon("disconnect");
        self endon("death");
        self endon("StopAmmoModifier");
 
        while(isDefined(self.AmmoModifier)) 
        {
            self.AmmoModifier = true;
            wait .15;
        }
    }
    else
        self notify("StopAmmoModifier");
        self.AmmoModifier = undefined;
}

SetAmmoMod(AmmoType){
    if(!isDefined(self.AmmoModifier))
    {
        self iPrintlnBold("Please enable the ammo modifier.");
        return;
    }
    
    self notify("StopAmmoModifier");
    wait 0.05;

    self endon("disconnect");
    self endon("StopAmmoModifier");
    
    while(isDefined(self.AmmoModifier)) 
    {
        self waittill(#"weapon_fired");

        MagicBullet(getWeapon(AmmoType), self getPlayerCameraPos(), BulletTrace(self getPlayerCameraPos(), self getPlayerCameraPos() + anglesToForward(self getPlayerAngles())  * 100000, false, self)["position"], self);
        wait .25;
    }
}
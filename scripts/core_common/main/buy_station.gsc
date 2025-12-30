BuyStation(){
    self createMenu("BuyStation", "Buy Station");
    self addOption("BuyStation", "Perk Menu", &OpenSubMenu, "BuyStationPerkMenu");
    self addOption("BuyStation", "Upgrades Menu", &OpenSubMenu, "UpgradesMenu");
    self addOption("BuyStation", "Specialist Menu", &OpenSubMenu, "SpecialistMenu");

    self createMenu("UpgradesMenu", "Upgrades Menu");
    self addOption("UpgradesMenu", "Buy Jetpack ($20,000)", &Jetpack, []);
    self addOption("UpgradesMenu", "Buy Recoil Reducer ($10,000)", &RecoilReducer, []);
    self addOption("UpgradesMenu", "Buy Increased Bullet Damage ($10,000)", &IncreasedBulletDamage, []);

    self createMenu("BuyStationPerkMenu", "Perk Menu");
    self addOption("BuyStationPerkMenu", "Buy Juggernog ($2,500)", &Juggernog, []);
    self addOption("BuyStationPerkMenu", "Buy Speed Cola ($3,500)", &SpeedCola, []);
    self addOption("BuyStationPerkMenu", "Buy Stamin-Up ($5,000)", &StaminUp, []);
    self addOption("BuyStationPerkMenu", "Buy Double-Tap ($7,000)", &BuyDoubletap, []);

    //Specialist menu is in personal_menu.gsc
}

Jetpack()
{
    if(self.points >= 20000)
    {
        self.points -= 20000;
        self setPerk("specialty_doublejump");
        self iPrintlnBold("^2You now have a jetpack.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}

RecoilReducer()
{
    if(self.points >= 10000)
    {
        self.points -= 10000;
        self setPerk("specialty_bulletaccuracy");
        self setPerk("specialty_accuracyandflatspread");
        self iPrintlnBold("^2You now have recoil control.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}

IncreasedBulletDamage()
{
    if(self.points >= 10000)
    {
        self.points -= 10000;
        self setPerk("specialty_bulletdamage");
        self setPerk(#"specialty_armorpiercing");
        self iPrintlnBold("^2You now have increased bullet damage.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}

BuyDoubletap()
{
    if(self.points >= 7500)
    {
        self.points -= 7500;
        self thread Doubletap();
        self iPrintlnBold("^2You now have double-tap.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}

DoubleTap(){
    while(true)
    {
        self waittill("weapon_fired");

        CurrentWeapon = self GetCurrentWeapon();

        if(!isDefined(CurrentWeapon))
            continue;

        for(a = 0; a < 3; a++)
        {
                MagicBullet(CurrentWeapon, self GetWeaponMuzzlePoint(), BulletTrace(self GetWeaponMuzzlePoint(), self GetWeaponMuzzlePoint() + self GetWeaponForwardDir() * 100, 0, undefined)["position"] + (RandomFloatRange(-5, 5), RandomFloatRange(-5, 5), RandomFloatRange(-5, 5)), self);
                wait 0.05;
        }
    }
}
    
BuyAttackDog()
{
    if(self.points >= 2500)
    {
        self.points -= 2500;
        self giveWeapon(getWeapon("dog_ai_defaultmelee"));
        wait .1;
        self giveMaxAmmo(getWeapon("dog_ai_defaultmelee"));
        wait .1;
        self switchToWeapon(getWeapon("dog_ai_defaultmelee"));
        self iPrintlnBold("^2You now have an attack dog.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}

SpeedCola()
{
    if(self.points >= 3500)
    {
        self.points -= 3500;
        self setPerk("specialty_fastads");
        self setPerk("specialty_fastreload");
        self setPerk("specialty_fastweaponswitch");
        self iPrintlnBold("^2You now have Speed Cola.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}

Juggernog(){
    if(self.points >= 2500)
    {
        self.points -= 2500;
        self.health = 250;
        self.maxhealth = 250;
        self iPrintlnBold("^2You now have Juggernog.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}

StaminUp(){
    if(self.points >= 5000)
    {
        self.points -= 5000;
        self SetToPlayer("specialty_playeriszombie");
        self iPrintlnBold("^2You now have Stamin-Up.");
    }
    else
    {
        self iPrintlnBold("^1Not enough points!");
    }
}
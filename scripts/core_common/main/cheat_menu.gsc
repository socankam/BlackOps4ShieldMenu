CheatMenu(){
    self createMenu("CheatMenu", "Cheat Menu ^1(Custom Zombies)");
    self addOption("CheatMenu", "Max Points", &MaxPoints, []);
    self addToggleOption("CheatMenu", "God Mode", &GodMode, false);
    self addToggleOption("CheatMenu", "Unlimited Ammo", &UnlimitedAmmo, false);
    self addToggleOption("CheatMenu", "Super Jump", &SuperJump, false);
    self addToggleOption("CheatMenu", "Super Speed", &SuperSpeed, false);
    self addToggleOption("CheatMenu", "Floating Dead Zombie Bodies", &FloatingBodies, false);
}
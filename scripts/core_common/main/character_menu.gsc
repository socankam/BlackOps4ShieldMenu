CharacterMenu(){
    init_characters();
    init_outfits();

    self createMenu("CharacterMenu", "Character Menu");
    self addOption("CharacterMenu", "Change Character", &OpenSubMenu, "ChangeCharacter");
    if(Multiplayer() || Blackout()){
        self addOption("CharacterMenu", "Change Outfit", &OpenSubMenu, "ChangeOutfit");
    }

    self createMenu("ChangeCharacter", "Character Menu");
    if(Multiplayer()){
        self addOption("ChangeCharacter", "John Doe", &SetCharacter, "JohnDoe");
        self addOption("ChangeCharacter", "Jane Doe", &SetCharacter, "JaneDoe");
        self addOption("ChangeCharacter", "Ajax", &SetCharacter, "Ajax");
        self addOption("ChangeCharacter", "Battery", &SetCharacter, "Battery");
        self addOption("ChangeCharacter", "Crash", &SetCharacter, "Crash");
        self addOption("ChangeCharacter", "Firebreak", &SetCharacter, "Firebreak");
        self addOption("ChangeCharacter", "Nomad", &SetCharacter, "Nomad");
        self addOption("ChangeCharacter", "Prophet", &SetCharacter, "Prophet");
        self addOption("ChangeCharacter", "Recon", &SetCharacter, "Recon");
        self addOption("ChangeCharacter", "Ruin", &SetCharacter, "Ruin");
        self addOption("ChangeCharacter", "Seraph", &SetCharacter, "Seraph");
        self addOption("ChangeCharacter", "Torque", &SetCharacter, "Torque");
        self addOption("ChangeCharacter", "Zero", &SetCharacter, "Zero");
        self addOption("ChangeCharacter", "Outrider", &SetCharacter, "Outrider");
        self addOption("ChangeCharacter", "Spectre", &SetCharacter, "Spectre");
        self addOption("ChangeCharacter", "Reaper", &SetCharacter, "Reaper");
    }
    if(Zombies()) {
        self addOption("ChangeCharacter", "Scarlett", &SetCharacter, "Scarlett");
        self addOption("ChangeCharacter", "Bruno", &SetCharacter, "Bruno");
        self addOption("ChangeCharacter", "Diego", &SetCharacter, "Diego");
        self addOption("ChangeCharacter", "Shaw", &SetCharacter, "Shaw");
        self addOption("ChangeCharacter", "Richtofen (Primis)", &SetCharacter, "Richtofen_Primis");
        self addOption("ChangeCharacter", "Dempsey (Primis)", &SetCharacter, "Dempsey_Primis");
        self addOption("ChangeCharacter", "Nikolai (Primis)", &SetCharacter, "Nikolai_Primis");
        self addOption("ChangeCharacter", "Takeo (Primis)", &SetCharacter, "Takeo_Primis");
        self addOption("ChangeCharacter", "Christina Fowler", &SetCharacter, "ChristinaFowler");
        self addOption("ChangeCharacter", "Jonathan Warwick", &SetCharacter, "JonathanWarwick");
        self addOption("ChangeCharacter", "Gideon Jones", &SetCharacter, "GideonJones");
        self addOption("ChangeCharacter", "Godfrey", &SetCharacter, "Godfrey");
        self addOption("ChangeCharacter", "Bruno (IX)", &SetCharacter, "Bruno_IX");
        self addOption("ChangeCharacter", "Diego (IX)", &SetCharacter, "Diego_IX");
        self addOption("ChangeCharacter", "Scarlett (IX)", &SetCharacter, "Scarlett_IX");
        self addOption("ChangeCharacter", "Shaw (IX)", &SetCharacter, "Shaw_IX");
        self addOption("ChangeCharacter", "Dempsey (Ultimis)", &SetCharacter, "Dempsey_Ultimis");
        self addOption("ChangeCharacter", "Nikolai (Ultimis)", &SetCharacter, "Nikolai_Ultimis");
        self addOption("ChangeCharacter", "Richtofen (Ultimis)", &SetCharacter, "Richtofen_Ultimis");
        self addOption("ChangeCharacter", "Takeo (Ultimis)", &SetCharacter, "Takeo_Ultimis");
        self addOption("ChangeCharacter", "Dempsey (Ultimis/AO)", &SetCharacter, "Dempsey_Ultimis_AO");
        self addOption("ChangeCharacter", "Nikolai (Ultimis/AO)", &SetCharacter, "Nikolai_Ultimis_AO");
        self addOption("ChangeCharacter", "Richtofen (Ultimis/AO)", &SetCharacter, "Richtofen_Ultimis_AO");
        self addOption("ChangeCharacter", "Takeo (Ultimis/AO)", &SetCharacter, "Takeo_Ultimis_AO");
        self addOption("ChangeCharacter", "Russman", &SetCharacter, "Russman");
        self addOption("ChangeCharacter", "Misty (Abigail Briarton)", &SetCharacter, "Misty_Abigail");
        self addOption("ChangeCharacter", "Marlton Johnson", &SetCharacter, "MarltonJohnson");
        self addOption("ChangeCharacter", "Samuel Stuhlinger", &SetCharacter, "SamuelStuhlinger");
        self addOption("ChangeCharacter", "Richtofen 2", &SetCharacter, "Richtofen2");
    }
    if(Blackout()) {
        self addOption("ChangeCharacter", "Ajax", &SetCharacter, "bo_Ajax");
        self addOption("ChangeCharacter", "Battery", &SetCharacter, "bo_Battery");
        self addOption("ChangeCharacter", "Crash", &SetCharacter, "bo_Crash");
        self addOption("ChangeCharacter", "Firebreak", &SetCharacter, "bo_Firebreak");
        self addOption("ChangeCharacter", "Nomad", &SetCharacter, "bo_Nomad");
        self addOption("ChangeCharacter", "Prophet", &SetCharacter, "bo_Prophet");
        self addOption("ChangeCharacter", "Recon", &SetCharacter, "bo_Recon");
        self addOption("ChangeCharacter", "Ruin", &SetCharacter, "bo_Ruin");
        self addOption("ChangeCharacter", "Seraph", &SetCharacter, "bo_Seraph");
        self addOption("ChangeCharacter", "Torque", &SetCharacter, "bo_Torque");
        self addOption("ChangeCharacter", "Dempsey (Ultimis)", &SetCharacter, "bo_Dempsey_Ultimis");
        self addOption("ChangeCharacter", "Nikolai (Ultimis)", &SetCharacter, "bo_Nikolai_Ultimis");
        self addOption("ChangeCharacter", "Richtofen (Ultimis)", &SetCharacter, "bo_Richtofen_Ultimis");
        self addOption("ChangeCharacter", "Takeo (Ultimis)", &SetCharacter, "bo_Takeo_Ultimis");
        self addOption("ChangeCharacter", "Dempsey (Primis)", &SetCharacter, "bo_Dempsey_Primis");
        self addOption("ChangeCharacter", "Nikolai (Primis)", &SetCharacter, "bo_Nikolai_Primis");
        self addOption("ChangeCharacter", "Richtofen (Primis)", &SetCharacter, "bo_Richtofen_Primis");
        self addOption("ChangeCharacter", "Takeo (Primis)", &SetCharacter, "bo_Takeo_Primis");
        self addOption("ChangeCharacter", "Shadow Man", &SetCharacter, "bo_Shadowman");
        self addOption("ChangeCharacter", "Bruno", &SetCharacter, "bo_Bruno");
        self addOption("ChangeCharacter", "Diego", &SetCharacter, "bo_Diego");
        self addOption("ChangeCharacter", "Scarlett", &SetCharacter, "bo_Scarlett");
        self addOption("ChangeCharacter", "Shaw", &SetCharacter, "bo_Shaw");
        self addOption("ChangeCharacter", "Bruno (IX)", &SetCharacter, "bo_Bruno_IX");
        self addOption("ChangeCharacter", "Diego (IX)", &SetCharacter, "bo_Diego_IX");
        self addOption("ChangeCharacter", "Scarlett (IX)", &SetCharacter, "bo_Scarlett_IX");
        self addOption("ChangeCharacter", "Shaw (IX)", &SetCharacter, "bo_Shaw_IX");
        self addOption("ChangeCharacter", "Reznov", &SetCharacter, "bo_Reznov");
        self addOption("ChangeCharacter", "Mason", &SetCharacter, "bo_Mason");
        self addOption("ChangeCharacter", "Woods", &SetCharacter, "bo_Woods");
        self addOption("ChangeCharacter", "Menendez", &SetCharacter, "bo_Menendez");
        self addOption("ChangeCharacter", "Player Man 1", &SetCharacter, "bo_PlayerMan1");
        self addOption("ChangeCharacter", "Player Man 2", &SetCharacter, "bo_PlayerMan2");
        self addOption("ChangeCharacter", "Player Man 3", &SetCharacter, "bo_PlayerMan3");
        self addOption("ChangeCharacter", "Player Man 4", &SetCharacter, "bo_PlayerMan4");
        self addOption("ChangeCharacter", "Player Woman 1", &SetCharacter, "bo_PlayerWoman1");
        self addOption("ChangeCharacter", "Player Woman 2", &SetCharacter, "bo_PlayerWoman2");
        self addOption("ChangeCharacter", "Player Woman 3", &SetCharacter, "bo_PlayerWoman3");
        self addOption("ChangeCharacter", "Player Woman 4", &SetCharacter, "bo_PlayerWoman4");
        self addOption("ChangeCharacter", "Hudson", &SetCharacter, "bo_Hudson");
        self addOption("ChangeCharacter", "Player Level 20", &SetCharacter, "bo_Player_Lvl20");
        self addOption("ChangeCharacter", "Player Level 40", &SetCharacter, "bo_Player_Lvl40");
        self addOption("ChangeCharacter", "Player Level 60", &SetCharacter, "bo_Player_Lvl60");
        self addOption("ChangeCharacter", "Player Level 80", &SetCharacter, "bo_Player_Lvl80");
        self addOption("ChangeCharacter", "Player Level 81", &SetCharacter, "bo_Player_Lvl81");
        self addOption("ChangeCharacter", "Zero", &SetCharacter, "bo_Zero");
        self addOption("ChangeCharacter", "Reaper (Classic)", &SetCharacter, "bo_Reaper_Classic");
        self addOption("ChangeCharacter", "Outrider", &SetCharacter, "bo_Outrider");
        self addOption("ChangeCharacter", "Misty (Abigail Briarton)", &SetCharacter, "bo_Misty");
        self addOption("ChangeCharacter", "Warden", &SetCharacter, "bo_Warden");
        self addOption("ChangeCharacter", "Cosmo", &SetCharacter, "bo_Cosmo");
        self addOption("ChangeCharacter", "Mason (Kid)", &SetCharacter, "bo_Mason_Kid");
        self addOption("ChangeCharacter", "John Doe", &SetCharacter, "bo_ZombieJoe");
        self addOption("ChangeCharacter", "Hudson (Cool)", &SetCharacter, "bo_Hudson_Cool");
        self addOption("ChangeCharacter", "Jane Doe", &SetCharacter, "bo_ZombieJane");
        self addOption("ChangeCharacter", "The Replacer", &SetCharacter, "bo_Replacer");
        self addOption("ChangeCharacter", "Spectre", &SetCharacter, "bo_Spectre");
        self addOption("ChangeCharacter", "Blackjack", &SetCharacter, "bo_Blackjack");
        self addOption("ChangeCharacter", "Sergei", &SetCharacter, "bo_Sergei");
        self addOption("ChangeCharacter", "Sarah Hall", &SetCharacter, "bo_SarahHall");
        self addOption("ChangeCharacter", "Woods (Old)", &SetCharacter, "bo_Woods_Old");
        self addOption("ChangeCharacter", "Menendez (Top1)", &SetCharacter, "bo_Menendez_Top1");
        self addOption("ChangeCharacter", "The Replacer (Green)", &SetCharacter, "bo_Replacer_Green");
        self addOption("ChangeCharacter", "Trejo", &SetCharacter, "bo_Trejo");
        self addOption("ChangeCharacter", "Russman", &SetCharacter, "bo_Russman");
        self addOption("ChangeCharacter", "M. Shadows", &SetCharacter, "bo_MShadows");
        self addOption("ChangeCharacter", "Reaper", &SetCharacter, "bo_Reaper");
        self addOption("ChangeCharacter", "Price (Classic)", &SetCharacter, "bo_Price_Classic");
        self addOption("ChangeCharacter", "T.E.D.D.", &SetCharacter, "bo_TEDD");
        self addOption("ChangeCharacter", "Weaver", &SetCharacter, "bo_Weaver");
        self addOption("ChangeCharacter", "Pentagon Thief", &SetCharacter, "bo_Pentagon_Thief");
        self addOption("ChangeCharacter", "Stuhlinger", &SetCharacter, "bo_Stuhlinger");
        self addOption("ChangeCharacter", "Marlton", &SetCharacter, "bo_Marlton");
    }

    self createMenu("ChangeOutfit", "Outfit Menu");
    self addOption("ChangeOutfit", "Ajax Outfits", &OpenSubMenu, "AjaxOutfits");
    self addOption("ChangeOutfit", "Battery Outfits", &OpenSubMenu, "BatteryOutfits");
    self addOption("ChangeOutfit", "Crash Outfits", &OpenSubMenu, "CrashOutfits");
    self addOption("ChangeOutfit", "Firebreak Outfits", &OpenSubMenu, "FirebreakOutfits");
    self addOption("ChangeOutfit", "Nomad Outfits", &OpenSubMenu, "NomadOutfits");
    self addOption("ChangeOutfit", "Outrider Outfits", &OpenSubMenu, "OutriderOutfits");
    self addOption("ChangeOutfit", "Prophet Outfits", &OpenSubMenu, "ProphetOutfits");
    self addOption("ChangeOutfit", "Reaper Outfits", &OpenSubMenu, "ReaperOutfits");
    self addOption("ChangeOutfit", "Recon Outfits", &OpenSubMenu, "ReconOutfits");
    self addOption("ChangeOutfit", "Ruin Outfits", &OpenSubMenu, "RuinOutfits");
    self addOption("ChangeOutfit", "Seraph Outfits", &OpenSubMenu, "SeraphOutfits");
    self addOption("ChangeOutfit", "Spectre Outfits", &OpenSubMenu, "SpectreOutfits");
    self addOption("ChangeOutfit", "Torque Outfits", &OpenSubMenu, "TorqueOutfits");
    self addOption("ChangeOutfit", "Zero Outfits", &OpenSubMenu, "ZeroOutfits");

    self createMenu("AjaxOutfits", "Ajax Outfits");
    self addOption("AjaxOutfits", "Chef", &SetOutfit, "Ajax_Chef");
    self addOption("AjaxOutfits", "Heist", &SetOutfit, "Ajax_Heist");
    self addOption("AjaxOutfits", "Money", &SetOutfit, "Ajax_Money");
    self addOption("AjaxOutfits", "Number", &SetOutfit, "Ajax_Number");
    self addOption("AjaxOutfits", "Twitch", &SetOutfit, "Ajax_Twitch");

    self createMenu("BatteryOutfits", "Battery Outfits");
    self addOption("BatteryOutfits", "Aviator", &SetOutfit, "Battery_Aviator");
    self addOption("BatteryOutfits", "Criminal", &SetOutfit, "Battery_Criminal");
    self addOption("BatteryOutfits", "Number", &SetOutfit, "Battery_Number");
    self addOption("BatteryOutfits", "Money", &SetOutfit, "Battery_Money");
    self addOption("BatteryOutfits", "Twitter", &SetOutfit, "Battery_Twitter");

    self createMenu("CrashOutfits", "Crash Outfits");
    self addOption("CrashOutfits", "Banana", &SetOutfit, "Crash_Banana");
    self addOption("CrashOutfits", "Magnum", &SetOutfit, "Crash_Magnum");
    self addOption("CrashOutfits", "Money", &SetOutfit, "Crash_Money");
    self addOption("CrashOutfits", "Number", &SetOutfit, "Crash_Number");
    self addOption("CrashOutfits", "Rambo", &SetOutfit, "Crash_Rambo");
    self addOption("CrashOutfits", "Rigor Mortis", &SetOutfit, "Crash_RigorMortis");
    self addOption("CrashOutfits", "Spectre", &SetOutfit, "Crash_Spectre");
    self addOption("CrashOutfits", "Twitch", &SetOutfit, "Crash_Twitch");

    self createMenu("FirebreakOutfits", "Firebreak Outfits");
    self addOption("FirebreakOutfits", "Money", &SetOutfit, "Firebreak_Money");
    self addOption("FirebreakOutfits", "Number", &SetOutfit, "Firebreak_Number");
    self addOption("FirebreakOutfits", "Rabbit", &SetOutfit, "Firebreak_Rabbit");
    self addOption("FirebreakOutfits", "Silverfish", &SetOutfit, "Firebreak_Silverfish");

    self createMenu("NomadOutfits", "Nomad Outfits");
    self addOption("NomadOutfits", "80", &SetOutfit, "Nomad_80");
    self addOption("NomadOutfits", "Elvis", &SetOutfit, "Nomad_Elvis");
    self addOption("NomadOutfits", "Money", &SetOutfit, "Nomad_Money");
    self addOption("NomadOutfits", "Number", &SetOutfit, "Nomad_Number");
    self addOption("NomadOutfits", "Twitch", &SetOutfit, "Nomad_Twitch");
    self addOption("NomadOutfits", "Pirate", &SetOutfit, "Nomad_Pirate");
    self addOption("NomadOutfits", "Werewolf", &SetOutfit, "Nomad_Werewolf");
    self addOption("NomadOutfits", "Zombie", &SetOutfit, "Nomad_Zombie");

    self createMenu("OutriderOutfits", "Outrider Outfits");
    self addOption("OutriderOutfits", "Blank", &SetOutfit, "Outrider_Blank");
    self addOption("OutriderOutfits", "Cheerleader", &SetOutfit, "Outrider_Cheerleader");
    self addOption("OutriderOutfits", "Heroes", &SetOutfit, "Outrider_Heroes");
    self addOption("OutriderOutfits", "Money", &SetOutfit, "Outrider_Money");
    self addOption("OutriderOutfits", "Number", &SetOutfit, "Outrider_Number");
    self addOption("OutriderOutfits", "Pirate", &SetOutfit, "Outrider_Pirate");

    self createMenu("ProphetOutfits", "Prophet Outfits");
    self addOption("ProphetOutfits", "Money", &SetOutfit, "Prophet_Money");
    self addOption("ProphetOutfits", "Number", &SetOutfit, "Prophet_Number");
    self addOption("ProphetOutfits", "Pirate", &SetOutfit, "Prophet_Pirate");
    self addOption("ProphetOutfits", "Plague", &SetOutfit, "Prophet_Plague");
    self addOption("ProphetOutfits", "Space", &SetOutfit, "Prophet_Space");
    self addOption("ProphetOutfits", "Twitch", &SetOutfit, "Prophet_Twitch");

    self createMenu("ReaperOutfits", "Reaper Outfits");
    self addOption("ReaperOutfits", "Spectre", &SetOutfit, "Reaper_Spectre");
    self addOption("ReaperOutfits", "Punk", &SetOutfit, "Reaper_Punk");
    self addOption("ReaperOutfits", "Number", &SetOutfit, "Reaper_Number");

    self createMenu("ReconOutfits", "Recon Outfits");
    self addOption("ReconOutfits", "Money", &SetOutfit, "Recon_Money");
    self addOption("ReconOutfits", "Number", &SetOutfit, "Recon_Number");
    self addOption("ReconOutfits", "Fish", &SetOutfit, "Recon_Fish");
    self addOption("ReconOutfits", "Snake", &SetOutfit, "Recon_Snake");
    self addOption("ReconOutfits", "Twitch", &SetOutfit, "Recon_Twitch");

    self createMenu("RuinOutfits", "Ruin Outfits");
    self addOption("RuinOutfits", "Biker", &SetOutfit, "Ruin_Biker");
    self addOption("RuinOutfits", "Hero", &SetOutfit, "Ruin_Hero");
    self addOption("RuinOutfits", "Money", &SetOutfit, "Ruin_Money");
    self addOption("RuinOutfits", "Muertos", &SetOutfit, "Ruin_Muertos");
    self addOption("RuinOutfits", "Number", &SetOutfit, "Ruin_Number");
    self addOption("RuinOutfits", "Police", &SetOutfit, "Ruin_Police");
    self addOption("RuinOutfits", "Twitch", &SetOutfit, "Ruin_Twitch");
    self addOption("RuinOutfits", "Zombie", &SetOutfit, "Ruin_Zombie");

    self createMenu("SeraphOutfits", "Seraph Outfits");
    self addOption("SeraphOutfits", "Heist", &SetOutfit, "Seraph_Heist");
    self addOption("SeraphOutfits", "Hero", &SetOutfit, "Seraph_Hero");
    self addOption("SeraphOutfits", "Money", &SetOutfit, "Seraph_Money");
    self addOption("SeraphOutfits", "Number", &SetOutfit, "Seraph_Number");
    self addOption("SeraphOutfits", "Police", &SetOutfit, "Seraph_Police");
    self addOption("SeraphOutfits", "Twitch", &SetOutfit, "Seraph_Twitch");
    self addOption("SeraphOutfits", "Vampire", &SetOutfit, "Seraph_Vampire");

    self createMenu("SpectreOutfits", "Spectre Outfits");
    self addOption("SpectreOutfits", "Apocalypse Z", &SetOutfit, "Spectre_ApocalypseZ");
    self addOption("SpectreOutfits", "Hero", &SetOutfit, "Spectre_Hero");
    self addOption("SpectreOutfits", "Japan", &SetOutfit, "Spectre_Japan");
    self addOption("SpectreOutfits", "Number", &SetOutfit, "Spectre_Number");
    self addOption("SpectreOutfits", "Twitch", &SetOutfit, "Spectre_Twitch");

    self createMenu("TorqueOutfits", "Torque Outfits");
    self addOption("TorqueOutfits", "Money", &SetOutfit, "Torque_Money");
    self addOption("TorqueOutfits", "Number", &SetOutfit, "Torque_Number");
    self addOption("TorqueOutfits", "Twitch", &SetOutfit, "Torque_Twitch");
    self addOption("TorqueOutfits", "Zombie Killer", &SetOutfit, "Torque_ZombieKiller");

    self createMenu("ZeroOutfits", "Zero Outfits");
    self addOption("ZeroOutfits", "Dark", &SetOutfit, "Zero_Dark");
    self addOption("ZeroOutfits", "Hero", &SetOutfit, "Zero_Hero");
    self addOption("ZeroOutfits", "Money", &SetOutfit, "Zero_Money");
    self addOption("ZeroOutfits", "Number", &SetOutfit, "Zero_Number");
    self addOption("ZeroOutfits", "Pirate", &SetOutfit, "Zero_Pirate");
    self addOption("ZeroOutfits", "Twitch", &SetOutfit, "Zero_Twitch");
    self addOption("ZeroOutfits", "Water", &SetOutfit, "Zero_Water");
    self addOption("ZeroOutfits", "Zombie", &SetOutfit, "Zero_Zombie");
}

init_characters() {
    self.Characters = array(
        array("JohnDoe", 15), array("JaneDoe", 16), array("Ajax", 1), array("Battery", 2), array("Crash", 3),
        array("Firebreak", 4), array("Nomad", 5), array("Prophet", 6), array("Recon", 7), array("Ruin", 8),
        array("Seraph", 9), array("Torque", 10), array("Zero", 11), array("Outrider", 12), array("Spectre", 13), array("Reaper", 14),

        array("Scarlett", 1), array("Bruno", 2), array("Diego", 3), array("Shaw", 4), array("Richtofen_Primis", 5),
        array("Dempsey_Primis", 6), array("Nikolai_Primis", 7), array("Takeo_Primis", 8), array("ChristinaFowler", 9),
        array("JonathanWarwick", 10), array("GideonJones", 11), array("Godfrey", 12), array("Bruno_IX", 13),
        array("Diego_IX", 14), array("Scarlett_IX", 15), array("Shaw_IX", 16), array("Dempsey_Ultimis", 17),
        array("Nikolai_Ultimis", 18), array("Richtofen_Ultimis", 19), array("Takeo_Ultimis", 20),
        array("Dempsey_Ultimis_AO", 21), array("Nikolai_Ultimis_AO", 22), array("Richtofen_Ultimis_AO", 23),
        array("Takeo_Ultimis_AO", 24), array("Russman", 25), array("Misty_Abigail", 26),
        array("MarltonJohnson", 27), array("SamuelStuhlinger", 28), array("Richtofen2", 29),

        array("bo_Ajax", 1), array("bo_Battery", 2), array("bo_Crash", 3), array("bo_Firebreak", 4), array("bo_Nomad", 5),
        array("bo_Prophet", 6), array("bo_Recon", 7), array("bo_Ruin", 8), array("bo_Seraph", 9), array("bo_Torque", 10),
        array("bo_Dempsey_Ultimis", 11), array("bo_Nikolai_Ultimis", 12), array("bo_Richtofen_Ultimis", 13),
        array("bo_Takeo_Ultimis", 14), array("bo_Dempsey_Primis", 15), array("bo_Nikolai_Primis", 16),
        array("bo_Richtofen_Primis", 17), array("bo_Takeo_Primis", 18), array("bo_Shadowman", 19), array("bo_Bruno", 20),
        array("bo_Diego", 21), array("bo_Scarlett", 22), array("bo_Shaw", 23), array("bo_Bruno_IX", 24),
        array("bo_Diego_IX", 25), array("bo_Scarlett_IX", 26), array("bo_Shaw_IX", 27), array("bo_Reznov", 28),
        array("bo_Mason", 29), array("bo_Woods", 30), array("bo_Menendez", 31), array("bo_PlayerMan1", 32),
        array("bo_PlayerMan2", 33), array("bo_PlayerMan3", 34), array("bo_PlayerMan4", 35), array("bo_PlayerWoman1", 36),
        array("bo_PlayerWoman2", 37), array("bo_PlayerWoman3", 38), array("bo_PlayerWoman4", 39), array("bo_Hudson", 40),
        array("bo_Player_Lvl20", 41), array("bo_Player_Lvl40", 42), array("bo_Player_Lvl60", 43),
        array("bo_Player_Lvl80", 44), array("bo_Player_Lvl81", 45), array("bo_Zero", 46), array("bo_Reaper_Classic", 47),
        array("bo_Outrider", 48), array("bo_Misty", 49), array("bo_Warden", 50), array("bo_Cosmo", 51),
        array("bo_Mason_Kid", 52), array("bo_ZombieJoe", 53), array("bo_Hudson_Cool", 54), array("bo_ZombieJane", 55),
        array("bo_Replacer", 56), array("bo_Spectre", 57), array("bo_Blackjack", 58), array("bo_Sergei", 59),
        array("bo_SarahHall", 60), array("bo_Woods_Old", 61), array("bo_Menendez_Top1", 62), array("bo_Replacer_Green", 63),
        array("bo_Trejo", 64), array("bo_Russman", 65), array("bo_MShadows", 66), array("bo_Reaper", 67),
        array("bo_Price_Classic", 68), array("bo_TEDD", 69), array("bo_Weaver", 70), array("bo_Pentagon_Thief", 71),
        array("bo_Stuhlinger", 72), array("bo_Marlton", 73)
    );
}

init_outfits() {
    self.Outfits = array(
        array("Ajax_Chef", 25), array("Ajax_Heist", 24), array("Ajax_Money", 16), array("Ajax_Number", 14), array("Ajax_Twitch", 19),

        array("Battery_Aviator", 25), array("Battery_Criminal", 21), array("Battery_Number", 14), array("Battery_Money", 16), array("Battery_Twitter", 19),

        array("Crash_Banana", 30), array("Crash_Magnum", 19), array("Crash_Money", 16), array("Crash_Number", 14), array("Crash_Rambo", 20),
        array("Crash_RigorMortis", 29), array("Crash_Spectre", 28), array("Crash_Twitch", 21),

        array("Firebreak_Money", 17), array("Firebreak_Number", 14), array("Firebreak_Rabbit", 15), array("Firebreak_Silverfish", 9),

        array("Nomad_80", 16), array("Nomad_Elvis", 17), array("Nomad_Money", 15), array("Nomad_Number", 13), array("Nomad_Twitch", 20),
        array("Nomad_Pirate", 23), array("Nomad_Werewolf", 31), array("Nomad_Zombie", 27),

        array("Outrider_Blank", 19), array("Outrider_Cheerleader", 14), array("Outrider_Heroes", 18), array("Outrider_Money", 3),
        array("Outrider_Number", 4), array("Outrider_Pirate", 10),

        array("Prophet_Money", 16), array("Prophet_Number", 14), array("Prophet_Pirate", 22), array("Prophet_Plague", 20),
        array("Prophet_Space", 28), array("Prophet_Twitch", 19),

        array("Reaper_Spectre", 1), array("Reaper_Punk", 2), array("Reaper_Number", 4),

        array("Recon_Money", 16), array("Recon_Number", 14), array("Recon_Fish", 22), array("Recon_Snake", 20), array("Recon_Twitch", 19),

        array("Ruin_Biker", 17), array("Ruin_Hero", 30), array("Ruin_Money", 14), array("Ruin_Muertos", 6), array("Ruin_Number", 15),
        array("Ruin_Police", 16), array("Ruin_Twitch", 21), array("Ruin_Zombie", 26),

        array("Seraph_Heist", 17), array("Seraph_Hero", 30), array("Seraph_Money", 18), array("Seraph_Number", 14), array("Seraph_Police", 16),
        array("Seraph_Twitch", 21), array("Seraph_Vampire", 24),

        array("Spectre_ApocalypseZ", 8), array("Spectre_Hero", 12), array("Spectre_Japan", 3), array("Spectre_Number", 4), array("Spectre_Twitch", 6),

        array("Torque_Money", 16), array("Torque_Number", 14), array("Torque_Twitch", 19), array("Torque_ZombieKiller", 21),

        array("Zero_Dark", 6), array("Zero_Hero", 23), array("Zero_Money", 27), array("Zero_Number", 26), array("Zero_Pirate", 16),
        array("Zero_Twitch", 13), array("Zero_Water", 14), array("Zero_Zombie", 19)
    );
}

SetCharacter(Character) {
    foreach (char in self.Characters) {
        if (char[0] == Character) {
            self setspecialistindex(char[1]);
            self player_role::update_fields();

            self setcharacteroutfit(0);
            self setcharacterwarpaintoutfit(0);
            
            slots = array("head", "headgear", "arms", "torso", "legs", "palette", "warpaint", "decal");

            for (i = 0; i < slots.size; i++) {
                self function_ab96a9b5(slots[i], 0);
            }
            return;
        }
    }
}

SetOutfit(Outfit) {
    foreach (entry in self.Outfits) {
        if (entry[0] == Outfit) {
            self setcharacteroutfit(entry[1]);
            return;
        }
    }
}
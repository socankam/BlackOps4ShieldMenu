//Credits to TheUnknownCod3r and G1llam for this, it's pretty much a copy and paste.
AccountMenu(){
    self createMenu("AccountMenu", "Account Menu");
    self addOption("AccountMenu", "Level 50", &Lvl50, []);
    self addOption("AccountMenu", "Level 1000", &Lvl1000, []);
    self addOption("AccountMenu", "Max Weapon Levels", &MaxWeaponLevels, []);
    self addOption("AccountMenu", "Unlock All Zombie Camos", &UnlockAllCamos, []);
    self addOption("AccountMenu", "Unlock All Achievements", &UnlockAchievements, []);
}

MaxWeaponLevels()
{
   self endon("disconnect");
    self iPrintln("Maxing out weapons, please wait...");
    foreach(gun in level.zombie_weapons)
    {
        self stats::set_stat(#"hash_60e21f66eb3a1f18", gun.weapon.name, #"xp", 665535);
        self stats::set_stat(#"hash_60e21f66eb3a1f18", gun.weapon.name, #"plevel", 2);
        
        wait 0.01;
    }

    attachments = Array(#"reflex", #"elo", #"acog", #"dualoptic", #"mms", #"holo");
    foreach(attachment in attachments)
    {
        self stats::set_stat(#"hash_2ea32bf38705dfdc", attachment, #"kills", #"StatValue", 5000);
        self stats::set_stat(#"hash_2ea32bf38705dfdc", attachment, #"kills", #"ChallengeValue", 5000);

        wait 0.01;
    }

    wait 0.1;
    UploadStats(self);
    self iPrintln("Max weapon ranks ^2set.");
}

UnlockAllCamos(){
    self iPrintln("Unlocking all camos, please wait...");
    foreach(weap in level.zombie_weapons)
    {
        self addweaponstat(weap.weapon, #"kills", 5000);
        self addweaponstat(weap.weapon, #"headshots", 5000);
        self addweaponstat(weap.weapon, #"allperkkills", 5000);
        self addweaponstat(weap.weapon, #"noperkkills", 5000);
        self addweaponstat(weap.weapon, #"packedkills", 5000);
        self addweaponstat(weap.weapon, #"heavykills", 5000);
        self addweaponstat(weap.weapon, #"minibosskills", 5000);
        self addweaponstat(weap.weapon, #"verminkills", 5000);
        self addweaponstat(weap.weapon, #"crawlerkills", 5000);
        self addweaponstat(weap.weapon, #"instakills", 5000);
        self addweaponstat(weap.weapon, #"hash_657e22dcdd18da77", 5000);
        wait(1);
    }
    self iPrintln("All camos ^2unlocked.");
}

UnlockAchievements()
{
    Achievements = array("zm_office_cold_war", "zm_office_ice", "zm_office_shock", "zm_office_power", "zm_office_strike", "zm_office_office", "zm_office_crawl", "zm_office_gas", "zm_office_pentupagon", "zm_office_everywhere", "zm_red_tragedy","zm_red_follower","zm_red_tribute","zm_red_mountains","zm_red_no_obol","zm_red_sun","zm_red_wind","zm_red_eagle","zm_red_defense","zm_red_gods", "zm_white_shard","zm_white_starting","zm_white_unlock","zm_white_mod","zm_white_trap","zm_white_pap","zm_white_knuckles","zm_white_perk","zm_white_stun","zm_white_roof","zm_trophy_doctor_is_in", "zm_trials_round_30","zm_escape_most_escape","zm_escape_patch_up","zm_escape_hot_stuff","zm_escape_hist_reenact","zm_escape_match_made","zm_escape_west_side","zm_escape_senseless","zm_escape_gat","zm_escape_throw_dog", "zm_orange_ascend","zm_orange_bells","zm_orange_freeze","zm_orange_hounds","zm_orange_totems","zm_orange_pack","zm_orange_secret","zm_orange_power","zm_orange_ziplines","zm_orange_jar","ZM_ZODT8_TRIAL_STEP_1", "ZM_MANSION_ARTIFACT","ZM_MANSION_STAKE","ZM_MANSION_BOARD","ZM_MANSION_BITE","ZM_MANSION_QUICK","ZM_MANSION_ALCHEMICAL","ZM_MANSION_CRAFTING","ZM_MANSION_SHOCKING","ZM_MANSION_CLOCK","ZM_MANSION_SHRINKING", "zm_towers_challenges","zm_towers_get_ww","zm_towers_trap_build","zm_towers_ww_kills","zm_towers_kitty_kitty","zm_towers_dismember","zm_towers_boss_kill","zm_towers_arena_survive","zm_towers_fast_pap", "ZM_ZODT8_ARTIFACT","ZM_ZODT8_STOWAWAY","ZM_ZODT8_DEEP_END","ZM_ZODT8_LITTLE_PACK","ZM_ZODT8_SHORTCUT","ZM_ZODT8_TENTACLE","ZM_ZODT8_STOKING","ZM_ZODT8_ROCK_PAPER","ZM_ZODT8_SWIMMING","zm_trophy_jack_of_all_blades", "zm_trophy_straw_purchase","zm_trophy_perkaholic_relapse","zm_trophy_gold","zm_rush_personal_score","zm_rush_team_score","zm_rush_multiplier_100","mp_trophy_special_issue_weaponry","mp_trophy_special_issue_equipment", "wz_specialist_super_fan","wz_first_win","wz_not_a_fluke","wz_blackout_historian","wz_specialist_super_fan","wz_zombie_fanatic","mp_trophy_battle_tested","mp_trophy_welcome_to_the_club","MP_SPECIALIST_MEDALS","MP_MULTI_KILL_MEDALS", "mp_trophy_vanquisher");

    foreach(Achievement in Achievements) 
    {
        self GiveAchievement(Achievement);
        self iPrintLn("^2" + Achievement + " unlocked");
        wait .5;
    }
    wait .5;
    self iPrintLn("^5All Achievements Unlocked");
}

Lvl50()
{
    self AddRankXPValue("kill", 1439600);
    self rank::updaterank();
    wait 0.1;
    UploadStats(self);
    self iPrintLn("You are now ^2level 55.");
}

Lvl1000()
{
    self AddRankXPValue("kill", 52486400);
    self rank::updaterank();
    wait 0.1;
    UploadStats(self);
    self iPrintLn("You are now ^2level 1000.");
}
SetGametypeSettings()
{
    if(Blackout()){
        SetupItemSettings();

        system::ignore(#"wz_stash_blackjack");
        system::ignore(#"hash_502d65acd9829223");

        setGametypeSetting(#"deathcircle", self.GameSettings["Enable Storm"]);
        setGametypeSetting(#"wzlootlockers", self.GameSettings["Enable Blackjack"]);
        setGametypeSetting(#"onlyheadshots", self.GameSettings["Allow Only Headshots"]);
        setGametypeSetting(#"playernumlives", self.GameSettings["Number Of Lives"]);
        setGametypeSetting(#"waverespawndelay", self.GameSettings["Respawn Delay"]);
        setGametypeSetting(#"wzzombiesmaxcount", self.GameSettings["Max Amount Of Zombies"]);
        setGametypeSetting(#"wzsnowballsenabled", self.GameSettings["Enable Snowballs"]);
        setGametypeSetting(#"wzenablewaverespawn", self.GameSettings["Enable Respawns"]);
        setGametypeSetting(#"wzwaterballoonsenabled", self.GameSettings["Enable Water Balloons"]);
        setGametypeSetting(#"wzenableblackjackstash", self.GameSettings["Enable Blackjack"]);
        setGametypeSetting(#"wzenablecontrabandstash", self.GameSettings["Enable Blackjack"]);

        setGametypeSetting(#"wzadddogs", 1);
        setGametypeSetting(#"wzaizones", 1);
        setGametypeSetting(#"wzzombies", 1);
        setGametypeSetting(#"wzminibosses", 1);
        setGametypeSetting(#"wzspawnanywhere", 1);
        setgametypesetting(#"zmzombieminspeed", 1);
        setgametypesetting(#"zmzombiemaxspeed", 4);
        setgametypesetting(#"wzzombieapocalypse", 1);
        setGametypeSetting(#"wzbrutuseverywhere", 1);
        setGametypeSetting(#"wzzombieapocalypse", 1);
        setGametypeSetting(#"wzzombiesspawnammo", 1);
        setGametypeSetting(#"wzenablewaverespawn", 0);
        setGametypeSetting(#"hash_14019eb043d9e43b", 1);
        setGametypeSetting(#"hash_3e2d2cf6b1cc6c68", 1);
        setGametypeSetting(#"wzhellhoundseverywhere", 1);
        setGametypeSetting(#"wzblightfatherseverywhere", 1);
        setGametypeSetting(#"wzzombiesattackablesenabled", 1);
        
        if(!self.GameSettings["Enable Perks"])
        {
            foreach (Perk in self.perkArray)
            {
                setGametypeSetting(Perk, 0);
            }
        }

        if(!self.GameSettings["Enable Armor"])
        {
            foreach (Armor in self.armorArray)
            {
                setGametypeSetting(Armor, 0);
            }
        }

        if(!self.GameSettings["Enable Attachments"])
        {
            foreach (Attachment in self.attachmentArray)
            {
                setGametypeSetting(Attachment, 0);
            }
        }

        if(!self.GameSettings["Enable Health Items"])
        {
            foreach (Health in self.healthArray)
            {
                setGametypeSetting(Health, 0);
            }
        }
    }

    if(Multiplayer()){
        setGametypeSetting(#"drafttime", self.GameSettings["Draft Time"]);
    }
}

SetupItemSettings()
{
    if(Blackout())
    {
        self.perkArray = array(
            #"wzenableperkparanoia", #"wzenableperkconsumer",
            #"wzenableperkironlungs", #"wzenableperkbrawler",
            #"wzenableperkawareness", #"wzenableperklooter",
            #"wzenableperksquadlink", #"wzenableperkreinforced",
            #"wzenableperkmedic", #"hash_78e459ad87509a46",
            #"wzenableperkdeadsilence", #"wzenableperkstimulant",
            #"wzenableperkmobility", #"wzenableperkengineer",
            #"wzenableperkoutlander"
        );

        self.armorArray = array(
            #"wzenablelv3armor", #"wzenablelv2armor",
            #"wzenablelv1armor", #"wzenablearmorplate"
        );

        self.attachmentArray = array(
            #"wzenable4xscope", #"wzenable3xscope",
            #"wzenable2xscope", #"wzenableextfastmag",
            #"wzenableextmag", #"wzenableextbarrel",
            #"wzenablefastmag", #"wzenableforegrip",
            #"wzenableholo", #"wzenablelasersight",
            #"wzenablepistolgrip", #"wzenablereflex",
            #"wzenablesniperscope", #"wzenablestock",
            #"wzenablesuppressor", #"wzenableelo"
        );

        self.healthArray = array(
            #"wzenablebandages", #"wzenablemedkit",
            #"wzenabletraumakit"
        );
    }
}

Blackout() {
    return sessionmodeiswarzonegame();
}

Zombies() {
    return sessionmodeiszombiesgame();
}

Multiplayer() {
    return sessionmodeismultiplayergame();
}

ChangeMap(Map) {
    if (level.CurrentMap == Map){
        self iPrintLnBold("Map is already loaded!");
    }
    else{
        if(Multiplayer() || Zombies()){
            setDvar("ls_mapname", Map);
            setDvar("mapname", Map);
            setDvar("party_mapname", Map);
            setDvar("ui_mapname", Map);
            setDvar("ui_currentmap", Map);
            setDvar("ui_previewmap", Map);
            setDvar("ui_showmap", Map);
        }
        map(Map);
        wait(1);
        switchmap_switch();
    }
}

ChangeMode(Mode) {
    Map = util::get_map_name();
    switchmap_load(Map, Mode);
    wait(1);
    switchmap_switch();
}

RestartMap()
{
    map_restart(0);
}

CurrentMapName()
{
    return util::get_map_name();
}
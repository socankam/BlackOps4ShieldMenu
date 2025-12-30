initcustomzombies()
{
    ai::registermatchedinterface("zombie_dog", "sprint", 0, array(1,0));
    ai::registermatchedinterface("zombie_dog", "min_run_dist", 500);

    self.customzombies = true;
    level.startingweapon = "pistol_standard_t8";

    level.camos = array(
    146, 147, 148, 149, 150,
    151, 152, 153, 154, 155,
    156, 157, 159, 160, 161,
    162, 163, 164, 165, 280,
    281, 282, 283, 284, 74,
    75, 76, 77, 78
    );

    level.zombiescharacters = array(
        "bo_Dempsey_Ultimis", "bo_Nikolai_Ultimis", "bo_Richtofen_Ultimis", "bo_Takeo_Primis", 
        "bo_Bruno", "bo_Diego", "bo_Scarlett", "bo_Shaw",
         "bo_Misty", "bo_Marlton", "bo_Russman", "bo_Stuhlinger"
    );

    level.buystationcoordinates = array(
        ""
    );
    level.currentRound = 1;
    level.zombiesInPlay = 0;
    level.dogRoundCount = 0;
    level.zombieKillCount = 0;

    foreach (player in level.players)
    {
        PlayerSettings(player);
        player CloseMenu();
        player thread setupMenu();
    }

    SetupMysteryBox();
    thread MonitorMysteryBox();
    if(self isHost())
    {
        thread CountdownHUD();
        thread PointsHUD();
    }
    thread StartCountdown();
    thread PlayZombieScreams();
}

StartCountdown()
{
    for (i = 10; i > 0; i--)
    {
        foreach (player in level.players)
        {
            if(self isHost()){
                ShieldHudElemSetText(#"Countdown", "^1Zombies coming in: ^2" + i);
            }
            else{
                player iprintlnbold("^1Zombies coming in: ^2" + i);
            }
        }
        wait 1;
    }

    foreach (player in level.players)
    {
        if(self isHost()){
            ShieldHudElemSetText(#"Countdown", "^1The undead are here!");
        }
        else{
            player iprintlnbold("^1The undead are here!");
        }
    }

    wait 2;
    ShieldRemoveHudElem(#"Countdown");
    thread StartRound();
}

StartRound()
{
    DoEarthquake();
    level.zombieKillCount = 0;
    level.zombiesInPlay = 0;
    level.zombiesSpawnedThisRound = 0;

    if (Blackout() && level.currentRound == 2)
    {
        level.dogRoundCount++;
        foreach (player in level.players)
        {
            //player iprintlnbold("^1Hellhounds incoming! Survive the round!");
        }
        //thread SpawnHellhounds();
    }
    else
    {
        level.zombiesPerRound[level.currentRound] = CalculateZombiesPerRound(level.currentRound);
        foreach (player in level.players)
        {
            if(!player isHost()) player iprintlnbold("^BHUD_OBIT_DEATH_SUICIDE^ ^1Round ^5" + level.currentRound + " ^2started!");
            if(Blackout()) player playsound(#"hash_1530a7e6184b9b2e");
        }
        thread SpawnZombies();
    }

    UpdateRoundHUD(level.currentRound);

    while (level.zombieKillCount < level.zombiesPerRound[level.currentRound] || level.zombiesInPlay > 0)
    {
        wait 1;
    }

    level.currentRound++;
    foreach (player in level.players)
    {
        if(!player isHost()) player iprintlnbold("^BHUD_OBIT_DEATH_SUICIDE^ ^1Round ^5" + level.currentRound + " ^2starting...");
    }

    if (Blackout() && level.currentRound > 4) 
        thread TrySpawnBrutus();

    wait 5;
    thread StartRound();
}

SpawnZombies()
{
    zombiesToSpawn = level.zombiesPerRound[level.currentRound];
    level.zombiesInPlay = 0;

    while (level.zombiesInPlay < zombiesToSpawn)
    {
        foreach (player in level.players)
        {
            if (isDefined(player) && level.zombiesInPlay < zombiesToSpawn)
            {
                player thread SpawnNewZombie(player);
                level.zombiesInPlay++;
            }
        }
        wait 1;
    }
}

CalculateZombiesPerRound(round)
{
    if (round == 1)
        return 5;
    else if (round == 2)
        return 8;
    else if (round == 3)
        return 11;
    else if (round < 10)
        return 11 + (round - 3) * 3;
    else
        return 30 + (round - 10) * 5;
}

SpawnNewZombie(player)
{
    if (!isDefined(player))
        return;

    if (Multiplayer()) {
        SpawnPosition = struct::get("mannequin_spawn_point", "targetname");
        var_ed5bd910 = struct::get_array("mannequin_spawn_landing_target", "targetname");

        if (!isDefined(SpawnPosition) || !isDefined(var_ed5bd910) || var_ed5bd910.size == 0)
            return;
    } 
    else if (Blackout()) {
        SpawnPosition = player.origin + vectorscale(anglestoforward(player.angles), 115);
        SpawnPosition = SpawnPosition + (0, 0, 50);
    }

    if (Blackout()) var_e5031929 = spawn("script_model", SpawnPosition);
    if (Multiplayer()) var_e5031929 = spawn("script_model", SpawnPosition.origin);
    var_e5031929 enablelinkto();
    var_e5031929 setmodel("tag_origin");
    var_e5031929.angles = (0, 0, 0);

    if (Multiplayer()) {
        Gender = randomint(2);
        Zombie = spawnactor(Gender == 1 ? "spawner_bo3_mannequin_male" : "spawner_bo3_mannequin_female", 
                            SpawnPosition.origin, SpawnPosition.angles, "mannequin", 1, 1);

        if (var_ed5bd910.size > 0) { 
            landing_point = var_ed5bd910[randomint(var_ed5bd910.size)];
            var_fall_speed = 1000;
            var_fall_time = distance(landing_point.origin, SpawnPosition.origin) / var_fall_speed;

            Zombie linkto(var_e5031929, "tag_origin", (0, 0, 0), (0, 0, 0));
            Zombie thread StartFallingAnimation();
            var_e5031929 moveto(landing_point.origin, var_fall_time, 3);
            Zombie thread StopFallingAnimation(var_e5031929);
        }
    } 
    if (Blackout()) {
        Type = randomInt(2);
        Zombie = spawnActor(Type == 1 ? #"spawner_boct_zombie_wz" : #"hash_618248fca82d83a6", SpawnPosition, (0, 0, 0), "zombie", 1, 1);
        ZombieEyeColor(Zombie);
        Zombie.var_721a3dbd = 0;
        Zombie.var_35eedf58 = 0;
        Zombie.var_ef59b90 = 3;
        Zombie.favoriteenemy = level.players[randomInt(level.players.size)];

        if (randomIntRange(0, 10) == 5) {
            Zombie attach(#"p8_zm_red_floatie_duck", "j_spinelower", 1);
        }
        SpawnPosition = GetSafeSpawnPosition(player);

        traceResult = bullettrace(SpawnPosition + (0, 0, 120), SpawnPosition - (0, 0, 1000), false, player);
        
        if (isDefined(traceResult["position"])) {
            SpawnPosition = traceResult["position"] + (0, 0, 50);
        } else {
            SpawnPosition = player.origin + (0, 0, 50);
        }
    }

    Zombie.var_e5031929 = var_e5031929;

    ZombieSpeed = randomint(100);
    RoundSpeedChance = level.currentRound * 5;

    Sprints = array("sprint", "super_sprint", "super_super_sprint");
    Zombies = getaiteamarray();

    foreach (CurrentZombie in Zombies) {
        if (ZombieSpeed <= 35) {
            CurrentZombie.zombie_move_speed = "walk";
        } else if (ZombieSpeed <= RoundSpeedChance) {
            CurrentZombie.zombie_move_speed = "run";
        } else {
            if(Blackout() || Multiplayer() && level.currentRound > 10) CurrentZombie.zombie_move_speed = Sprints[randomInt(Sprints.size)];
        }
    }

    thread MonitorZombie(Zombie, player);
}

GetSafeSpawnPosition(player)
{
    safeDistanceMin = 200;
    safeDistanceMax = 300;
    angleOffset = randomInt(360);

    forwardVector = anglesToForward((0, angleOffset, 0)); 
    distance = randomIntRange(safeDistanceMin, safeDistanceMax);
    
    spawnOffset = vectorScale(forwardVector, distance);
    spawnOffset = spawnOffset + anglesToRight(player.angles) * randomIntRange(-200, 200);

    spawnPosition = player.origin + spawnOffset + (0, 0, 120);

    traceResult = bullettrace(spawnPosition + (0, 0, 120), spawnPosition - (0, 0, 1000), false, player);
    
    if (isDefined(traceResult["position"])) {
        spawnPosition = traceResult["position"] + (0, 0, 50);
    } else {
        spawnPosition = player.origin + (0, 0, 50);
    }

    return spawnPosition;
}

MonitorZombie(Zombie, player)
{
    if (!isDefined(Zombie) || !isDefined(player))
        return;

    while (isDefined(Zombie) && isAlive(Zombie))
    {
        wait 0.1;

        if (Blackout())
        {
            distanceToPlayer = Distance(Zombie.origin, player.origin);
            if (distanceToPlayer > 1000)
            {
                if (isDefined(Zombie) && isAlive(Zombie)) 
                {
                    thread AwardPoints(player);

                    Zombie delete();
                    level.zombiesInPlay--;

                    if (level.zombiesInPlay < 0)
                        level.zombiesInPlay = 0;

                    if (level.zombiesInPlay < level.zombiesPerRound[level.currentRound] && level.zombieKillCount < level.zombiesPerRound[level.currentRound])
                    {
                        thread RespawnZombieNearPlayer(player);
                    }
                }
                return;
            }
        }

        if (!isAlive(Zombie))
        {
            level.zombiesInPlay--;

            if (level.zombiesInPlay < 0)
                level.zombiesInPlay = 0;

            level.zombieKillCount++;

            thread AwardPoints(player);

            if (level.zombieKillCount >= level.zombiesPerRound[level.currentRound])
            {
                return;
            }
        }
    }
}

AwardPoints(player)
{
    if (!isDefined(player))
        return;

    possiblePoints = array(25, 50, 75, 100);
    pointsAwarded = possiblePoints[randomInt(possiblePoints.size)];

    if (player.points < 999999) {
        player.points += pointsAwarded;

        if (player isHost()) {
            thread AddPointsHUD(pointsAwarded);
        } else {
            player iprintlnbold("^2+" + pointsAwarded + " Points! | ^3Points: ^5" + player.points);
        }
    }
}

RespawnZombieNearPlayer(player)
{
    if (!isDefined(player))
        return;

    if (level.zombiesInPlay >= level.zombiesPerRound[level.currentRound] || level.zombieKillCount >= level.zombiesPerRound[level.currentRound]) 
    {
        return;
    }

    SpawnPosition = GetSafeSpawnPosition(player);

    traceResult = bullettrace(SpawnPosition + (0, 0, 120), SpawnPosition - (0, 0, 1000), false, player);
        
    if (isDefined(traceResult["position"])) 
    {
        SpawnPosition = traceResult["position"] + (0, 0, 50);
    } 

    Type = randomInt(2);
    Zombie = spawnactor(Type == 1 ? #"spawner_boct_zombie_wz" : #"hash_618248fca82d83a6", SpawnPosition, (0, 0, 0), "zombie", 1, 1);
    
    ZombieEyeColor(Zombie);
    Zombie.var_721a3dbd = 0;
    Zombie.var_35eedf58 = 0;
    Zombie.var_ef59b90 = 3;
    Zombie.favoriteenemy = level.players[randomInt(level.players.size)];

    if (randomIntRange(0, 10) == 5) 
    {
        Zombie attach(#"p8_zm_red_floatie_duck", "j_spinelower", 1);
    }

    level.zombiesInPlay++;

    thread MonitorZombie(Zombie, player);
}


StartFallingAnimation()
{
    self endon(#"death", #"landed");
    while (true)
    {
        animation::play(#"hash_1f02283eb11fce2a", self.origin, self.angles, 1, 0.2, 0.2, 0, 0, 0, 0);
    }
}

StopFallingAnimation(var_e5031929)
{
    self endoncallback(&function_6bc3bcb8, #"death");
    var_e5031929 waittill(#"movedone");

    self notify(#"landed");
    self unlink();
    var_e5031929 delete();

    animation::play(#"hash_4c2aa742b1aeb780", self.origin, self.angles, 1, 0.4, 0.2, 0, 0, 0, 0);
}

function_6bc3bcb8(notifyhash) {
    if (isdefined(self) && isdefined(self.var_e5031929)) {
        self.var_e5031929 delete();
    }
}

ZombieEyeColor(Zombie){
    EyeColor = randomIntRange(1, 4);
    Zombie clientfield::set("zombie_has_eyes_col", EyeColor);
}

SpawnHellhounds()
{
    hellhoundsToSpawn = 5 + (level.dogRoundCount * 2);
    level.zombiesInPlay = 0;

    while (level.zombiesInPlay < hellhoundsToSpawn)
    {
        foreach (player in level.players)
        {
            if (isDefined(player) && level.zombiesInPlay < hellhoundsToSpawn)
            {
                player thread SpawnNewHellhound(player);
                level.zombiesInPlay++;
            }
        }
        wait 1;
    }
}

SpawnNewHellhound(player)
{
    if (!isDefined(player))
        return;

    SpawnPosition = GetSafeSpawnPosition(player);

    traceResult = bullettrace(SpawnPosition + (0, 0, 120), SpawnPosition - (0, 0, 1000), false, player);
        
    if (isDefined(traceResult["position"])) 
    {
        SpawnPosition = traceResult["position"] + (0, 0, 50);
    } 

    Hellhound = spawnactor(#"spawner_boct_zombie_dog_wz", SpawnPosition, self.angles, "dog", 1, 1);
    Hellhound.favoriteenemy = level.players[randomInt(level.players.size)];
    Hellhound.var_721a3dbd = 0;
    Hellhound.var_35eedf58 = 0;
    Hellhound.var_ef59b90 = 3;
    Hellhound ai::set_behavior_attribute("sprint", 1);
}

TrySpawnBrutus()
{
    BrutusChance = randomint(2);
    if (BrutusChance == 0)
    {
        foreach(player in level.players) thread SpawnBrutus(player);
    }
}

SpawnBrutus(player)
{
    if (!isDefined(player)) return;

    SpawnPosition = player.origin + (randomfloatrange(-400, 400), randomfloatrange(-400, 400), 0);
    Brutus = spawnactor(#"spawner_boct_brutus_wz", SpawnPosition, player.angles, "brutus", 1, 1);
    Brutus.favoriteenemy = level.players[randomInt(level.players.size)];
    Brutus.var_721a3dbd = 0;
    Brutus.var_35eedf58 = 0;
    Brutus.var_ef59b90 = 5;

    foreach (player in level.players)
    {
        player iprintlnbold("^1A powerful enemy is approaching...");
    }

    Ai = getaiarray();
    foreach(Brutus in Ai) {
        Brutus.zombie_move_speed = "run";
    }

    thread MonitorZombie(Brutus, player);
}

FormatPoints(points)
{
    if (points < 10)
        return "00000" + points;
    else if (points < 100)
        return "0000" + points;
    else if (points < 1000)
        return "000" + points;
    else if (points < 10000)
        return "00" + points;
    else if (points < 100000)
        return "0" + points;
    else
        return points;
}

PlayerSettings(player){
    characterIndex = randomint(level.zombiescharacters.size);
    selectedCharacter = level.zombiescharacters[characterIndex];
    if(Blackout()) SetCharacter(selectedCharacter);

    player.points = 0;
    player.nextZombieMilestone = 500;
    player.nextRobotMilestone = 2000;
    player.milestoneActive = false;
    
    player setclientuivisibilityflag("g_compassShowEnemies", 1);
    if(Multiplayer()){
        player takeAllWeapons();
        player giveWeapon(getWeapon(level.startingweapon));
        wait .1;
        player giveMaxAmmo(getWeapon(level.startingweapon));
        wait .1;
        player switchToWeapon(getWeapon(level.startingweapon));
    }

    player thread RegenerateHealth(player);
}

RegenerateHealth(player)
{
    player endon("death");
    
    while (true)
    {
        wait 1;
        
        if (player.health < player.maxhealth)
        {
            wait 3;

            while (player.health < player.maxhealth)
            {
                player.health += 10;
                if (player.health > player.maxhealth)
                {
                    player.health = player.maxhealth;
                }

                wait 1;
            }
        }
    }
}

MonitorMysteryBox()
{
    level.mysteryBoxCooldown = false;

    while (true)
    {
        foreach (player in level.players)
        {
            if (!isDefined(player)) continue;

            distance = distance(player.origin, level.mysteryBoxLocation);
            
            if (distance <= 150 && !level.mysteryBoxCooldown) 
            {
                player iprintlnbold("^2Hold Melee ^BHUD_OBIT_KNIFE^ to use Mystery Box for ^3950 Points!");

                wait 0.5;

                while (distance(player.origin, level.mysteryBoxLocation) <= 150)
                {
                    if (player MeleeButtonPressed()) 
                    {
                        if (player.points >= 950)
                        {
                            player.points -= 950;
                            level.mysteryBoxCooldown = true;
                            
                            player playsound("mpl_fracture_deposit_1");
                            player thread GiveMysteryBoxWeapon();

                            wait 5;
                            level.mysteryBoxCooldown = false;
                        }
                        else
                        {
                            player iprintlnbold("^1Not enough points!");
                        }
                    }
                    wait 0.2;
                }

                player iprintlnbold("");
            }
        }
        wait 0.5;
    }
}

GiveMysteryBoxWeapon()
{
    weaponIndex = randomint(level.mysteryBoxWeapons.size);
    selectedWeapon = level.mysteryBoxWeapons[weaponIndex];

    weaponDisplayName = "Unknown"; 
    foreach (entry in level.weaponNameMap) {
        if (entry[1] == selectedWeapon) {
            weaponDisplayName = entry[0];  
            break;
        }
    }

    self iprintlnbold("^2You've received a ^5" + weaponDisplayName + "!"); 

    self giveWeapon(getWeapon(selectedWeapon));
    wait .1;
    self giveMaxAmmo(getWeapon(selectedWeapon));
    wait .1;
    self switchToWeapon(getWeapon(selectedWeapon));
    self SetWeaponAmmoClip(self GetCurrentWeapon(), self GetCurrentWeapon().clipsize);
    
    camoIndex = randomint(level.camos.size);
    selectedCamo = level.camos[camoIndex];
    self setcamo(getWeapon(selectedWeapon), selectedCamo);
}

SetupMysteryBox()
{
    level.mysteryBoxWeapons = array(
        "smg_vmp_t8", "smg_standard_t8", "shotgun_pump_t8", "shotgun_semiauto_t8",
        "ray_gun", "ar_peacekeeper_t8", "ar_fastfire_t8", "ar_modular_t8",
        "sniper_locus_t8", "pistol_fullauto_t8", "smg_fastfire_t8", "tr_damageburst_t8",
        "smg_capacity_t8", "ar_accurate_t8", "smg_minigun_t8", "ar_galil_t8", "lmg_stealth_t8",
        "smg_folding_t8", "tr_midburst_t8", "ar_stealth_t8", "shotgun_fullauto_t8"
    );

    level.weaponNameMap = array(
        array("VMP", #"smg_vmp_t8"), array("MX9", #"smg_standard_t8"),
        array("MOG 12", #"shotgun_pump_t8"), array("SG12", #"shotgun_semiauto_t8"),
        array("Ray Gun", #"ray_gun"), array("Peacekeeper", #"ar_peacekeeper_t8"),
        array("Maddox", #"ar_fastfire_t8"), array("KN-57", #"ar_modular_t8"),
        array("Locus", #"sniper_locus_t8"), array("KAP-45", #"pistol_fullauto_t8"),
        array("Spitfire", #"smg_fastfire_t8"), array("M16", #"tr_damageburst_t8"),
        array("Cordite", #"smg_capacity_t8"), array("ICR-7", #"ar_accurate_t8"),
        array("MicroMG", #"smg_minigun_t8"), array("Grav", #"ar_galil_t8"),
        array("Tigershark", #"lmg_stealth_t8"), array("Switchblade X9", #"smg_folding_t8"),
        array("ABR .223", #"tr_midburst_t8"), array("Vapr-XKG", #"ar_stealth_t8"),
        array("Rampage", #"shotgun_fullauto_t8")
    );

    level.mysteryBoxCost = 950;
    if(Multiplayer()) {
        level.mysteryBoxLocation = (397.043, 930.758, -60);
        level.mysteryBoxModel = spawn("script_model", level.mysteryBoxLocation);
        level.mysteryBoxModel setModel("p8_wz_pot_of_gold_pristine");
    }
    if(Blackout()){
        level.mysteryBoxLocation = (397.043, 930.758, -60);
        MysteryBox = spawn("script_model", self.origin);
        MysteryBox setmodel(#"hash_1dcbe8021fb16344");
    }
}

PlayZombieScreams() {
    while (true) {
        wait randomintrange(3, 7);

        foreach (player in level.players) {
            if (!isDefined(player)) 
                continue;

            scream = randomint(2) == 0 ? #"hash_61fc4fa3eeafcf07" : #"hash_64441bbb83e130e9";

            player playsound(scream);
        }
    }
}

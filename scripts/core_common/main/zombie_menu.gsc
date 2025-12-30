ZombieMenu()
{
    self createMenu("ZombieMenu", "Zombies Menu");
    if(Zombies()) self addOption("ZombieMenu", "Zombie Options", &OpenSubMenu, "FunZombieOptions");
    self addOption("ZombieMenu", "Zombie Speed Changer", &OpenSubMenu, "ZombieSpeedMenu");
    if(Zombies()) self addOption("ZombieMenu", "AAT Mods (Ammo)", &OpenSubMenu, "AmmoModifier");
    if(Zombies()) self addOption("ZombieMenu", "Points Menu", &OpenSubMenu, "PointsMenu");
    
    if(Blackout()){
        self addOption("ZombieMenu", "Change Zombie Eye Colors", &OpenSubMenu, "ZombieEyeColors");
        self addOption("ZombieMenu", "Zombie Spawner", &OpenSubMenu, "ZombieSpawner");
    }

    self createMenu("FunZombieOptions", "Zombie Options");
    self addToggleOption("FunZombieOptions", "Plasma Loop", &PlasmaLoop, false);
    self addOption("FunZombieOptions", "Spawn Luna Wolf (Protector)", &SpawnLunaWolf, []);
    self addToggleOption("FunZombieOptions", "Zombies Ignore You", &NoTarget, false);
    self addOption("FunZombieOptions", "Zombies Have Duck Floaties", &ZombieDuckFloaties, []);
    self addOption("FunZombieOptions", "Kill All Zombies", &KillAllZombies, []);
    self addOption("FunZombieOptions", "Open All Doors", &OpenAllDoors, []);
    self addOption("FunZombieOptions", "Teleport All Zombies To You", &TeleportAllZombies, []);
    self addToggleOption("FunZombieOptions", "Free Mystery Box", &FreeMysteryBox, false);
    self addToggleOption("FunZombieOptions", "Mystery Box Doesn't Move", &FreezeMysteryBox, false); 
    self addOption("FunZombieOptions", "Headless Zombies", &HeadlessZombies, []);
    self addToggleOption("FunZombieOptions", "Invisible Zombies", &InvisibleZombies, false);
    self addToggleOption("FunZombieOptions", "Freeze Zombies", &FreezeZombies, false);
    self addToggleOption("FunZombieOptions", "Zombies On Fire", &ZombieDogFX, false);
    self addToggleOption("FunZombieOptions", "Disable Zombie Spawning", &DisableZombieSpawning, false);
    self addOption("FunZombieOptions", "Reset Round", &ResetRound, []);

    self createMenu("ZombieEyeColors", "Zombie Eye Colors");
    self addToggleOption("ZombieEyeColors", "Flashing Eye Colors", &FlashingEyeColors, false);
    self addOption("ZombieEyeColors", "Set Eye Colors To Blue", &SetEyeColor, "blue");
    self addOption("ZombieEyeColors", "Set Eye Colors To Green", &SetEyeColor, "green");
    self addOption("ZombieEyeColors", "Set Random Eye Color", &SetEyeColor, "random");
    self addOption("ZombieEyeColors", "Invisible Eyes", &SetEyeColor, "invisible");

    self createMenu("PointsMenu", "Points Menu");
    self addOption("PointsMenu", "5,000 Points", &EditPoints, "5000");
    self addOption("PointsMenu", "10,000 Points", &EditPoints, "10000");
    self addOption("PointsMenu", "25,000 Points", &EditPoints, "25000");
    self addOption("PointsMenu", "50,000 Points", &EditPoints, "50000");
    self addOption("PointsMenu", "75,000 Points", &EditPoints, "75000");
    self addOption("PointsMenu", "100,000 Points", &EditPoints, "100000");
    self addOption("PointsMenu", "Give Max Points", &EditPoints, "999999");
    self addOption("PointsMenu", "Take All Points", &EditPoints, "0");

    self createMenu("ZombieSpeedMenu", "Zombie Speed Modifier");
    self addOption("ZombieSpeedMenu", "Zombies Walk", &ZombieSpeed, "walk");
    self addOption("ZombieSpeedMenu", "Zombies Run", &ZombieSpeed, "run");
    self addOption("ZombieSpeedMenu", "Zombies Sprint", &ZombieSpeed, "sprint");
    self addOption("ZombieSpeedMenu", "Zombies Super-Sprint", &ZombieSpeed, "super_sprint");

    self createMenu("AmmoModifier", "Apply Ammo Mods");
    self addOption("AmmoModifier", "Fire Bomb", &GiveWeaponAAT, "zm_aat_plasmatic_burst");
    self addOption("AmmoModifier", "Kill-o-Watt", &GiveWeaponAAT, "zm_aat_kill_o_watt");
    self addOption("AmmoModifier", "Cryofreeze", &GiveWeaponAAT, "zm_aat_frostbite");
    self addOption("AmmoModifier", "Brain Rot", &GiveWeaponAAT, "zm_aat_brain_decay");

    self createMenu("ZombieSpawner", "Zombie Spawner");
    self addOption("ZombieSpawner", "Spawn Zombie", &SpawnZombie, "zombie");
    self addOption("ZombieSpawner", "Spawn Hell Hound", &SpawnZombie, "hellhound");
    self addOption("ZombieSpawner", "Spawn Brutus", &SpawnZombie, "brutus");
    self addOption("ZombieSpawner", "Spawn Avogadro", &SpawnZombie, "avogadro");
}

GiveWeaponAAT(aat)
{
    self endon("disconnect");
    a = self getcurrentweapon();
    self aat::acquire(a, aat);
}

ResetRound(){
    level flag::set("round_reset");
}

DisableZombieSpawning(){
    self.DisableZombieSpawning = isDefined(self.DisableZombieSpawning) ? undefined : true;
 
    if(isDefined(self.DisableZombieSpawning))
    {
        level flag::clear("spawn_zombies");
    }
    else
        level flag::set("spawn_zombies");
}

ZombieAttachModel(model)
{
    model = ishash(model) ? model : hash(model);

    foreach(zombie in GetAITeamArray(level.zombie_team))
    {
        zombie DetachAll();
        zombie setModel(model);
    }
}

ZombieDogFX()
{

    self.ZombieDogFX = isDefined(self.ZombieDogFX) ? undefined : true;

    if (isDefined(self.ZombieDogFX))
    {
        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            zombies[a] clientfield::set("dog_fx", 1);
        }
    }
    else
    {
        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            zombies[a] clientfield::set("dog_fx", 0);
        }
    }
}

FreezeZombies()
{

    self.FreezeZombies = isDefined(self.FreezeZombies) ? undefined : true;

    if (isDefined(self.FreezeZombies))
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z setentitypaused(1);
        }
    }
    else
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z setentitypaused(0);
        }
    }
}

InvisibleZombies()
{

    self.InvisibleZombies = isDefined(self.InvisibleZombies) ? undefined : true;

    if (isDefined(self.InvisibleZombies))
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z hide();
        }
    }
    else
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z show();
        }
    }
}

ZombieSpeed(speed) {
    if (!isdefined(speed)) {
        level.var_43fb4347 = undefined; 
        level.var_102b1301 = undefined;
        a_e_zombies = getaiarray();
        foreach(e_zombie in a_e_zombies) {
            if (isdefined(e_zombie.zombie_move_speed_backupobj)) {
                e_zombie.zombie_move_speed = e_zombie.zombie_move_speed_backupobj;
            } else {
                e_zombie.zombie_move_speed = "walk";
            }
        }
    } else {
        a_e_zombies = getaiarray();
        foreach(e_zombie in a_e_zombies) {
            e_zombie.zombie_move_speed_backupobj = e_zombie.zombie_move_speed;
            e_zombie.zombie_move_speed = speed;
        }
        level.var_43fb4347 = speed; 
        level.var_102b1301 = speed;
    }
}

HeadlessZombies()
{
    zombies = GetAITeamArray(level.zombie_team);
    
    for(a = 0; a < zombies.size; a++)
    {
        if(IsDefined(zombies[a]) && IsAlive(zombies[a]))
            zombies[a] DetachAll();
    }
}

EditPoints(Points){
    self.score = int(Points);
}

MaxPoints()
{
    foreach (player in level.players)
    {
        if (isDefined(player)) 
        {
            player.points = 999999;
            player iprintlnbold("^2Max points given! Points: ^5" + player.points);
        }
    }
}

PlasmaLoop()
{
    self.PlasmaLoop = isDefined(self.PlasmaLoop) ? undefined : true;

    if(isDefined(self.PlasmaLoop))
    {
        self endon("disconnect");

        while(isDefined(self.PlasmaLoop))
        {
            self function_e8f77739(#"zm_timeplayed", 1000000);
            wait 0.1;
        }
    }
}

StartZombiesAimbot()
{
    self.Aimbot = isDefined(self.Aimbot) ? undefined : true;
 
    if(isDefined(self.Aimbot))
    {
        self endon("disconnect");

        while(isDefined(self.Aimbot)) 
        {
            self thread ZombiesAimbot();
            wait 0.1;
        }
    }
    else
        self notify("StopAimbot");
}

ZombiesAimbot()
{
    self endon("disconnect");
    self endon("StopAimbot");

    self.Aimbot = isDefined(self.Aimbot) ? undefined : true;
 
    if(isDefined(self.Aimbot)){
        while(isDefined(self.Aimbot))
        {
            ClosestZombie = Array::get_all_closest(self.origin, GetAITeamArray(level.zombie_team));
            
            if(self isFiring() && ClosestZombie.size > 0 && isAlive(ClosestZombie[0]) && !self IsMeleeing())
            {
                Loc = ClosestZombie[0] gettagorigin("tag_origin");
                
                self setplayerangles(VectorToAngles((Loc) - (self gettagorigin("tag_origin"))));
                wait .05;
                ClosestZombie[0] dodamage(ClosestZombie[0].maxhealth + 666, ClosestZombie[0].origin, self);
            }
            wait .05;
        }
    }
    else{
        self notify("StopAimbot");
    }
}

ChangeRound(Round){
    world.roundnumber = int(Round) ^ 115;
    KillAllZombies();
}

SpawnLunaWolf()
{
    spawnactor(#"hash_3f174b9bcc408705", self.origin, self.angles, "wolf_protector", 1);
}

ZombieDuckFloaties()
{
    Zombies = GetAiSpeciesArray("axis","all");
    for(i=0;i<Zombies.size;i++)
    {
        Zombies[i] attach(#"p8_zm_red_floatie_duck", "j_spinelower");
    }
}

NoTarget()
{
    self.NoTarget = isDefined(self.NoTarget) ? undefined : true;
    if (isDefined(self.NoTarget))
        self.ignoreme = true;
    else
        self.ignoreme = false;
}

KillAllZombies() {
    if (!isdefined(level.zombie_team)) {
        return;
    }
    foreach(zombie in getaiteamarray(level.zombie_team)) 
    {
        if (isdefined(zombie)) {
            zombie dodamage(zombie.maxhealth + 666, zombie.origin, self);
        }
    }
}

SpawnZombie(ZombieType)
{
    self.ZombieTypes = undefined;
    
    self.ZombieTypes["zombie"] = #"spawner_boct_zombie_wz";
    self.ZombieTypes["hellhound"] = #"spawner_boct_zombie_dog_wz";
    self.ZombieTypes["brutus"] =  #"spawner_boct_brutus_wz";
    self.ZombieTypes["avogadro"] =  #"spawner_boct_avogadro";

    Look = self GetLookPosition();
    ZombieAi = spawnactor(self.ZombieTypes[ZombieType], Look, (0, 0, 0));
    ZombieAi.var_721a3dbd = 0;
    ZombieAi.var_35eedf58 = 0;
    ZombieAi.var_ef59b90 = 3;
    ZombieAi.favoriteenemy = self;
}

SetEyeColor(EyeColor)
{
    Random = randomIntRange(1, 4);
    
    if (!isdefined(level.var_5b357434)) 
    {
        return;
    }

    self.EyeColors = undefined;
    
    self.EyeColors["invisible"] = 0;
    self.EyeColors["default"] = 1;
    self.EyeColors["blue"] = 2;
    self.EyeColors["green"] = 3;
    self.EyeColors["random"] = Random;

    ZombieAI = getaiteamarray(#"world");

    foreach (Zombie in ZombieAI) {
        if (isalive(Zombie)) {
            Zombie clientfield::set("zombie_has_eyes_col", self.EyeColors[EyeColor]);
        }
    }
}

FlashingEyeColors()
{
    self.FlashingEyeColors = isDefined(self.FlashingEyeColors) ? undefined : true;
 
    if(isDefined(self.FlashingEyeColors))
    {
        self endon("disconnect");
        self endon("StopFlashingEyes");

        ZombieAI = getaiteamarray(#"world");

        while(isDefined(self.FlashingEyeColors)) 
        {
            Random = randomIntRange(1, 4);
            foreach (Zombie in ZombieAI) {
                if (isalive(Zombie)) {
                    Zombie clientfield::set("zombie_has_eyes_col", Random);
                }
            }
            wait 0.1;
        }
    }
    else{
        self notify("StopFlashingEyes");
    }
}

OpenAllDoors() // From Lucy Menu
{
	setdvar(#"zombie_unlock_all", 1);
	level flag::set("power_on");
	level clientfield::set("zombie_power_on", 1);
	power_trigs = getentarray("use_elec_switch", "targetname");
	foreach(trig in power_trigs)
	{
		if(isdefined(trig.script_int))
		{
			level flag::set("power_on" + trig.script_int);
			level clientfield::set("zombie_power_on", trig.script_int + 1);
		}
	}
	players = getplayers();
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
	{
		if(!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened))
		{
			zombie_doors[i] notify(#"trigger", {#activator:players[0]});
		}
		if(isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait)
		{
			zombie_doors[i] notify(#"power_on");
		}
		waitframe(1);
	}
	zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
	for(i = 0; i < zombie_airlock_doors.size; i++)
	{
		zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
		waitframe(1);
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	for(i = 0; i < zombie_debris.size; i++)
	{
		if(isdefined(zombie_debris[i]))
		{
			zombie_debris[i] notify(#"trigger", {#activator:players[0]});
		}
		waitframe(1);
	}
	wait(1);
	setdvar(#"zombie_unlock_all", 0);
}

TeleportAllZombies() 
{
    foreach(zombie in getaiteamarray(level.zombie_team))  
    {
        if (isDefined(zombie)) zombie ForceTeleport(self.origin + (+40, 0, 0));
    }
}

FreeMysteryBox()
{
    self.FreeBox = isDefined(self.FreeBox) ? undefined : true;
 
    if(isDefined(self.FreeBox))
    {
        self endon("disconnect");
 
        foreach(chest in level.chests) chest.zombie_cost = 0;
    }
    else
        foreach(chest in level.chests) chest.zombie_cost = 950;
}

FreezeMysteryBox()
{
    self.FreezeBox = isDefined(self.FreezeBox) ? undefined : true;
 
    if(isDefined(self.FreezeBox))
    {
        self endon("disconnect");
 
        level.chests[level.chest_index].no_fly_away = true;
    }
    else
        level.chests[level.chest_index].no_fly_away = false;
}
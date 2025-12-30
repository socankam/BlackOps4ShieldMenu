ForgeMenu(){
    initModels();
    self createMenu("ForgeMenu", "Forge Menu");
    if(Multiplayer()){
        self addOption("ForgeMenu", "Spawn Drop Tower", &SpawnDropTower, []);
        self addOption("ForgeMenu", "Spawn Merry-Go-Round", &SpawnMerryGoRound, []);
        self addOption("ForgeMenu", "Spawn Sky Base (Only Spawn One)", &SpawnSkyBase, []);
        if(level.CurrentMap == "mp_nuketown_4"){
            self addOption("ForgeMenu", "Spawn Male Mannequin", &SpawnModel, "spawner_bo3_mannequin_male");
            self addOption("ForgeMenu", "Spawn Female Mannequin", &SpawnModel, "spawner_bo3_mannequin_female");
            self addOption("ForgeMenu", "Spawn Red Bus", &SpawnModelFromHash, "RedBus");
            self addOption("ForgeMenu", "Spawn Jeep", &SpawnModelFromHash, "NuketownJeep");
        }
        if(level.CurrentMap == "mp_firingrange2" || level.CurrentMap == "mp_firingrange2_alt"){
            self addOption("ForgeMenu", "Spawn Target", &SpawnModelFromHash, "Target");
            self addOption("ForgeMenu", "Spawn Green Car", &SpawnModelFromHash, "GreenCar");
        }
        self addOption("ForgeMenu", "Spawn Care Package (Axis)", &SpawnModel, "p8_care_package_01_a");
        self addOption("ForgeMenu", "Spawn Care Package (Ally)", &SpawnModel, "p8_care_package_02_a");
        self addOption("ForgeMenu", "Spawn Wall", &SpawnWall, []);
        self addOption("ForgeMenu", "Spawn Swat Team Male", &SpawnModel, "spawner_mp_swat_buddy_team1_male");
        self addOption("ForgeMenu", "Spawn Robot", &SpawnModel, "spawner_bo3_robot_grunt_assault_mp");
        self addOption("ForgeMenu", "Spawn Pot Of Gold", &SpawnModel, "p8_wz_pot_of_gold_pristine");
    }
    if(Blackout()){
        self addOption("ForgeMenu", "Spawn Snowman", &SpawnModel, "p8_wz_ep_snowman");
        self addOption("ForgeMenu", "Spawn Mystery Box", &SpawnModelFromHash, "MysteryBox");
        self addOption("ForgeMenu", "Spawn Medical Stash", &SpawnModelFromHash, "MedicalStash");
        self addOption("ForgeMenu", "Spawn Skull Throne", &SpawnModel, "p8_wz_ep_skull_throne");
        self addOption("ForgeMenu", "Spawn Money Stack", &SpawnModel, "p8_wz_ep_money_stack");
        self addOption("ForgeMenu", "Spawn Beach Ball", &SpawnModel, "p8_wz_ep_beach_ball");
        self addOption("ForgeMenu", "Spawn Briefcase", &SpawnModel, "p8_wz_ep_briefcase");
        self addOption("ForgeMenu", "Spawn Jack-o-Lantern", &SpawnModel, "p8_wz_ep_jack_o_lantern");
        self addOption("ForgeMenu", "Spawn Surfboard", &SpawnModel, "p8_wz_ep_surfboard");
        self addOption("ForgeMenu", "Spawn Raygun Model", &SpawnModel, "p8_wz_ep_raygun");
        self addOption("ForgeMenu", "Spawn Sword", &SpawnModel, "p8_wz_ep_sword");
        self addOption("ForgeMenu", "Spawn Valentine Heart", &SpawnModel, "p8_wz_ep_valentine_heart");
        self addOption("ForgeMenu", "Spawn Homonculus", &SpawnModel, "p8_wz_ep_homunculus");
        self addOption("ForgeMenu", "Spawn Soccer Ball", &SpawnModel, "p8_wz_ep_ball_soccer");
        self addOption("ForgeMenu", "Spawn Basketball", &SpawnModel, "p8_wz_ep_basketball");
        self addOption("ForgeMenu", "Spawn Football", &SpawnModel, "p8_wz_ep_football");
        self addOption("ForgeMenu", "Spawn Boombox", &SpawnModel, "p8_wz_ep_boombox_retro");
        self addOption("ForgeMenu", "Spawn Cardboard Box", &SpawnModel, "p8_wz_ep_box_cardboard");
        self addOption("ForgeMenu", "Spawn Pinwheel", &SpawnModel, "p8_wz_ep_pinwheel");
        self addOption("ForgeMenu", "Spawn Hula Hoop", &SpawnModel, "p8_wz_ep_hula_hoop");
        self addOption("ForgeMenu", "Spawn White Flag", &SpawnModel, "p8_wz_ep_white_flag");
        self addOption("ForgeMenu", "Spawn Door", &SpawnModel, "p8_wz_door_01");
        self addOption("ForgeMenu", "Spawn Wood Door", &SpawnModel, "p8_wz_door_01_wood");
    }
    if(Zombies()){
        self addOption("ForgeMenu", "Spawn PAP Machine", &SpawnModel, "p7_zm_vending_packapunch");
        self addOption("ForgeMenu", "Spawn Revive Machine", &SpawnModel, "p7_zm_vending_revive");
    }
}

initModels(){
    //Use the "ADS Model Print" function to find more hashes.
    self.ModelHashMap = array(
        array("GreenCar", #"hash_453afd7b132d3bb3"), array("Target", #"hash_766d66c61d59df8d"), 
        array("MysteryBox", #"hash_1dcbe8021fb16344"), array("RedBus", #"hash_2f187915564f7681"), array("NuketownJeep", #"hash_58ba46554622b573"),
        array("MedicalStash", #"hash_574076754776e003")
    );
}

SpawnModel(Model){
    Look = self GetLookPosition();
    Object = spawn("script_model", Look);
    Object setModel(Model);

    self iprintlnBold("Spawned Object at: " + Look);
}

SpawnModelFromHash(Model){
    Look = self GetLookPosition();
    Object = spawn("script_model", Look);

    foreach (obj in self.ModelHashMap) 
    {
        if (obj[0] == Model) 
        {
            Object setModel(obj[1]);
            break;
        }
    }

    self iprintlnBold("Spawned Object at: " + Look);
}

GetLookPosition()
{
    return self GetLookTrace()["position"];
}

GetLookTrace()
{
    eyePos = self geteye();
    aimDir = AnglesToForward(self GetPlayerAngles());

    maxDistance = 10000;

    return bullettrace(eyePos, eyePos + vectorscale(aimDir, maxDistance), true, self);
}

SpawnDropTower()
{
    self endon("disconnect");

    basePos = self.origin;
    towerHeight = 11;
    spacing = 60;
    dropSpeed = 8.0;
    liftSpeed = 2.5;
    waitTime = 1.5;

    platformOffset = 40;

    platformHeight = basePos[2] + (towerHeight * spacing);
    dropHeight = basePos[2];

    for (i = 0; i < towerHeight; i++)
    {
        pos = (basePos[0], basePos[1], basePos[2] + (i * spacing));
        obj = spawn("script_model", pos);
        obj setModel("p8_care_package_01_a");
    }

    platform = spawn("script_model", (basePos[0] + platformOffset, basePos[1], platformHeight));
    platform setModel("p8_care_package_01_a");

    wait 2;

    while (1)
    {
        for (z = dropHeight; z <= platformHeight; z += liftSpeed)
        {
            platform.origin = (basePos[0] + platformOffset, basePos[1], z);
            wait 0.05;
        }

        wait waitTime;

        for (z = platformHeight; z >= dropHeight; z -= dropSpeed)
        {
            platform.origin = (basePos[0] + platformOffset, basePos[1], z);
            wait 0.03;
        }

        wait 2;
    }
}

SpawnMerryGoRound()
{
    self endon("disconnect");

    centerPos = self.origin;
    radius = 175;
    numSeats = 6;
    rotationSpeed = 4;

    seats = [];
    angleStep = 360 / numSeats; 

    for (i = 0; i < numSeats; i++)
    {
        angle = i * angleStep;
        x = centerPos[0] + (radius * cos(angle));
        y = centerPos[1] + (radius * sin(angle));
        z = centerPos[2];

        seat = spawn("script_model", (x, y, z));
        seat setModel("p8_care_package_01_a");
        seats[i] = seat;
    }

    self iprintlnBold("^3Merry-Go-Round Starting! Hold on!");
    
    seatIndex = randomInt(numSeats);
    self linkTo(seats[seatIndex]);

    wait 2;

    self thread MonitorJumpToExit();
    
    BuildCentralStructure(centerPos);

    while (1)
    {
        for (rotation = 0; rotation < 360; rotation += rotationSpeed)
        {
            for (i = 0; i < numSeats; i++)
            {
                angle = (i * angleStep) + rotation;
                x = centerPos[0] + (radius * cos(angle));
                y = centerPos[1] + (radius * sin(angle));

                seats[i].origin = (x, y, centerPos[2]);
            }

            wait 0.05;
        }
    }
}

MonitorJumpToExit()
{
    self endon("disconnect");
    while (1)
    {
        if (self jumpbuttonpressed())
        {
            self unlink();
            self iprintlnBold("^1You jumped off!");
            break;
        }
        wait 0.05;
    }
}

BuildCentralStructure(origin)
{
    wallModels = [];
    wallModels[0] = "p8_care_package_02_a";
    wallModels[1] = "p8_care_package_02_a";
    wallModels[2] = "p8_care_package_02_a";
    wallModels[3] = "p8_care_package_02_a";

    wallPositions = [];
    wallPositions[0] = (origin[0] + 100, origin[1], origin[2]);
    wallPositions[1] = (origin[0] - 100, origin[1], origin[2]);
    wallPositions[2] = (origin[0], origin[1] + 100, origin[2]);
    wallPositions[3] = (origin[0], origin[1] - 100, origin[2]);

    wallAngles = [];
    wallAngles[0] = (0, 90, 0);
    wallAngles[1] = (0, -90, 0);
    wallAngles[2] = (0, 0, 0);
    wallAngles[3] = (0, 180, 0);

    for (i = 0; i < 4; i++)
    {
        wall = spawn("script_model", wallPositions[i]);
        wall setModel(wallModels[i]);
        wall.angles = wallAngles[i];
    }

    roof = spawn("script_model", (origin[0], origin[1], origin[2] + 100));
    roof setModel("p8_care_package_02_a");
}

SpawnSkyBase()
{
    self endon("disconnect");

    basePos = self.origin;  
    baseHeight = 1000;      
    baseSize = 7;           
    spacing = 55;           
    levelSpacing = 300;     

    halfSize = int(baseSize / 2); 

    minX = 0 - halfSize;
    maxX = halfSize;
    minY = 0 - halfSize;
    maxY = halfSize;

    skyBasePos = (basePos[0], basePos[1], basePos[2] + baseHeight);

    for (x = minX; x <= maxX; x++)
    {
        for (y = minY; y <= maxY; y++)
        {
            if ((x == minX && y == minY) || (x == minX + 1 && y == minY))
                continue;
                
            pos = (skyBasePos[0] + (x * spacing), skyBasePos[1] + (y * spacing), skyBasePos[2]);
            obj = spawn("script_model", pos);
            obj setModel("p8_care_package_01_a");
        }
    }

    stairStart = (skyBasePos[0] + (minX * spacing), skyBasePos[1], skyBasePos[2]);
    stairGap = 20;
    numSteps = 6;
    stepHeight = (levelSpacing - stairGap) / numSteps;

    for (i = 0; i < numSteps; i++)
    {
        stairPos = (stairStart[0] + (i * spacing), stairStart[1], stairStart[2] + (i * stepHeight));
        step = spawn("script_model", stairPos);
        step setModel("p8_care_package_01_a");
    }

    secondFloorPos = (skyBasePos[0], skyBasePos[1], skyBasePos[2] + levelSpacing);
    for (x = minX; x <= maxX; x++)
    {
        for (y = minY; y <= maxY; y++)
        {
            if ((x == minX && y == minY) || (x == minX + 1 && y == minY) || (x == maxX && y == maxY))
                continue;
                
            pos = (secondFloorPos[0] + (x * spacing), secondFloorPos[1] + (y * spacing), secondFloorPos[2]);
            obj = spawn("script_model", pos);
            obj setModel("p8_care_package_01_a");
        }
    }

    stairStart2 = (secondFloorPos[0] + (minX * spacing), secondFloorPos[1], secondFloorPos[2]);
    for (i = 0; i < numSteps; i++)
    {
        stairPos = (stairStart2[0] + (i * spacing), stairStart2[1], stairStart2[2] + (i * stepHeight));
        step = spawn("script_model", stairPos);
        step setModel("p8_care_package_01_a");
    }

    roofPos = (skyBasePos[0], skyBasePos[1], skyBasePos[2] + (levelSpacing * 2));
    for (x = minX; x <= maxX; x++)
    {
        for (y = minY; y <= maxY; y++)
        {
            if ((x == minX && y == minY) || (x == minX + 1 && y == minY) || (x == maxX && y == maxY))
                continue;

            pos = (roofPos[0] + (x * spacing), roofPos[1] + (y * spacing), roofPos[2]);
            obj = spawn("script_model", pos);
            obj setModel("p8_care_package_01_a");
        }
    }

    elevatorStart = (skyBasePos[0] + (maxX * spacing), skyBasePos[1] + (maxY * spacing), skyBasePos[2]); 
    elevatorEnd = (skyBasePos[0] + (maxX * spacing), skyBasePos[1] + (maxY * spacing), roofPos[2] - 50); 

    elevator = spawn("script_model", elevatorStart);
    elevator setModel("p8_care_package_01_a");

    self thread MoveElevator(elevator, elevatorStart, elevatorEnd);

    for (x = minX; x <= maxX; x++)
    {
        for (z = skyBasePos[2]; z <= roofPos[2]; z += spacing)
        {
            if (x == maxX) continue;
            wallPos1 = (skyBasePos[0] + (x * spacing), skyBasePos[1] + (minY * spacing), z);
            wallPos2 = (skyBasePos[0] + (x * spacing), skyBasePos[1] + (maxY * spacing), z);
            wall1 = spawn("script_model", wallPos1);
            wall2 = spawn("script_model", wallPos2);
            wall1 setModel("p8_care_package_01_a");
            wall2 setModel("p8_care_package_01_a");
        }
    }

    for (y = minY; y <= maxY; y++)
    {
        for (z = skyBasePos[2]; z <= roofPos[2]; z += spacing)
        {
            if (y == maxY) continue;
            wallPos = (skyBasePos[0] + (minX * spacing), skyBasePos[1] + (y * spacing), z);
            wall = spawn("script_model", wallPos);
            wall setModel("p8_care_package_01_a");
        }
    }

    self setOrigin((skyBasePos[0], skyBasePos[1], skyBasePos[2] + 50));
}

MoveElevator(elevator, startPos, endPos)
{
    while (1)
    {
        for (z = startPos[2]; z <= endPos[2]; z += 10)
        {
            elevator.origin = (startPos[0], startPos[1], z);
            wait 0.05;
        }

        wait 2; 

        for (z = endPos[2]; z >= startPos[2]; z -= 10)
        {
            elevator.origin = (startPos[0], startPos[1], z);
            wait 0.05;
        }

        wait 2; 
    }
}

SpawnWall() {
    carePackageModel = "p8_care_package_01_a";
    spacing = 25;

    width = 10;
    height = 3;
    for (x = 0; x < width; x++)
    {
        for (z = 0; z < height; z++)
        {
            position = (self.origin[0] + (x * spacing), self.origin[1], self.origin[2] + (z * spacing));
            package = spawn("script_model", position);
            package setModel(carePackageModel);
        }
    }
    forward = anglesToForward(self getAngles());
    newPosition = self.origin + (forward * 128);
    self setOrigin(newPosition);
} 
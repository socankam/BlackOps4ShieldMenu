VisionMenu()
{
    self createMenu("VisionMenu", "Vision Menu");
    if(Zombies()){
        self addToggleOption("VisionMenu", "Last Stand Vision", &LastStandPostFX, false);
        self addToggleOption("VisionMenu", "Chaos Light Vision", &ChaosLight, false);
        self addToggleOption("VisionMenu", "Plus Signs FX", &NearDeath, false);
        self addToggleOption("VisionMenu", "Star Gate Vision", &StarGate, false);
    }
    self addToggleOption("VisionMenu", "Fire Vision", &EnableFireVision, false);
    self addToggleOption("VisionMenu", "Dead Ops Arcade", &DeadOpsArcadeToggle, false);
    if(util::get_map_name() == "zm_escape") self addToggleOption("VisionMenu", "Foggy Map", &DoFog, false);
}

DoFog()
{
    self.DoFog = isDefined(self.DoFog) ? undefined : true;
 
    if(isDefined(self.DoFog))
    {
        self endon("disconnect");
        
        level thread clientfield::set("dog_round_fog_bank", 1);
    }
    else{
        level thread clientfield::set("dog_round_fog_bank", 0);
    }
}

ChaosLight()
{
    self.ChaosLight = isDefined(self.ChaosLight) ? undefined : true;
 
    if(isDefined(self.ChaosLight))
    {
        self endon("disconnect");
        self clientfield::set( "fasttravel_rail_fx", 1 );
        self clientfield::set_to_player( "player_chaos_light_rail_fx", 1 );
    }
    else{
        self clientfield::set( "fasttravel_rail_fx", 0 );
        self clientfield::set_to_player( "player_chaos_light_rail_fx", 0 );
    }
}

NearDeath()
{
    self.NearDeath = isDefined(self.NearDeath) ? undefined : true;
 
    if(isDefined(self.NearDeath))
    {
        self endon("disconnect");
         self clientfield::set_to_player( "zm_bgb_near_death_experience_1p_fx", 1 );
    }
    else{
         self clientfield::set_to_player( "zm_bgb_near_death_experience_1p_fx", 0 );
    }
}

StarGate()
{
    self.StarGate = isDefined(self.StarGate) ? undefined : true;
 
    if(isDefined(self.StarGate))
    {
        self endon("disconnect");
        self clientfield::set_to_player( "player_stargate_fx", 1 );
        self clientfield::set_to_player( "fasttravel_teleport_sfx", 1 );
    }
    else{
        self clientfield::set_to_player( "player_stargate_fx", 0 );
        self clientfield::set_to_player( "fasttravel_teleport_sfx", 0 );
    }
}

LastStandPostFX()
{
    self.LastStandPostFX = isDefined(self.LastStandPostFX) ? undefined : true;

    if (isDefined(self.LastStandPostFX))
        self clientfield::set("zm_last_stand_postfx", 1);
    else
        self clientfield::set("zm_last_stand_postfx", 0);
}

DeadOpsArcadeToggle() {
    self.DeadOpsArcade = isDefined(self.DeadOpsArcade) ? undefined : true;
    if(isDefined(self.DeadOpsArcade))
    {
        self endon("EndDeadOpsArcade");
        while(isDefined(self.DeadOpsArcade))
        {
            birdsEyeCamera = spawn("script_model", self.origin + (0, 0, 600));
            birdsEyeCamera.angles = (90, 90, 0);
            birdsEyeCamera setModel("tag_origin");
            self CameraSetLookAt(birdsEyeCamera);
            self CameraSetPosition(birdsEyeCamera);
            self CameraActivate(true);
            
            temporaryOffset = 600;
            for(;;) {
                sightPassed = SightTracePassed(self.origin + (0, 0, 600), self.origin, false, birdsEyeCamera);
                if (sightPassed && birdsEyeCamera.origin[2] - self.origin[2] < 600) {
                    temporaryOffset = birdsEyeCamera.origin[2] - self.origin[2];
                    while (temporaryOffset < 600) {
                        temporaryOffset += 10;
                        birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
                        wait 0.01;
                    }
                }
                while (!SightTracePassed(self.origin + (0, 0, temporaryOffset), self.origin, false, birdsEyeCamera)) {
                    temporaryOffset -= 20;
                    birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
                    wait 0.01;
                }
                self SetPlayerAngles(self GetPlayerAngles() * (0, 1, 0));
                birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
                wait 0.01;
            }
        }
            
    }
    else{
         self notify("EndDeadOpsArcade");
         self CameraActivate(false);
    }
}
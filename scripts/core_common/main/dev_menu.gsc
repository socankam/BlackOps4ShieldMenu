DevMenu(){
    self createMenu("DevMenu", "Dev Menu");
    self addToggleOption("DevMenu", "Model Hash Print", &ADSModelPrint, false);
    self addOption("DevMenu", "Print Position", &PrintPosition, []);
    self addOption("DevMenu", "Print XUID", &PrintXUID, []);
}

PrintXUID(){
    self iPrintlnBold("XUID: " + self getXUID());
}

ADSModelPrint(){
    self.ADSModelPrint = isDefined(self.ADSModelPrint) ? undefined : true;
 
    if(isDefined(self.ADSModelPrint))
    {
        self endon("disconnect");
        self iPrintln("^2ADS at an object to print its hash value.");
        while(isDefined(self.ADSModelPrint)) 
        {
            self thread StartModelPrint();
            wait 0.1;
        }
    }
    else
        self notify("StopModelPrint");
}

StartModelPrint()
{
    self endon("disconnect");
    self endon("StopModelPrint");

    lastModel = "";

    while (isDefined(self.ADSModelPrint))
    {
        while (self adsbuttonpressed()) 
        {
            trace = bulletTrace(self GetTagOrigin("j_head"), self GetTagOrigin("j_head") + anglesToForward(self GetPlayerAngles()) * 1000000, true, self);
            
            if (isDefined(trace["entity"]) && isDefined(trace["entity"].model)) 
            {
                if (trace["entity"].model != lastModel)
                {
                    self iprintlnbold("Model: hash_" + trace["entity"].model);
                    lastModel = trace["entity"].model;
                }
            } 
            else if (lastModel != "No entity hit") 
            {
                self iprintlnbold("No entity hit");
                lastModel = "No entity hit";
            }

            wait 0.1;
        }
        wait 0.05;
    }
}

PrintPosition(){
    pos = self.origin;
    self iPrintlnBold("Position: X=" + pos[0] + " Y=" + pos[1] + " Z=" + pos[2]);
}
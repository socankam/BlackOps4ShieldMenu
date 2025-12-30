MenuHUDS()
{
    self.Top    = -615;
    self.Bottom = 65;
    self.Left   = -875 - 400;

    self.tsize = 31;
    self.Size  = 8;

    if (isDefined(self.HUD) && self.HUD)
    {
        for (i = 0; i < 40; i++)
            ShieldRegisterHudElem(
                #"TitleBar" + i,
                self.primaryColor + "_",
                0xFFFFC0EB,
                -199 + i * 10, 93 + 300,
                1, 0,
                0, 0,
                0.50
            );
        for (i = 0; i < 110; i++)
            ShieldRegisterHudElem(
                #"FooterBar" + i,
                self.primaryColor + "_",
                0xFFFFC0EB,
                -199 + i * 10, 745 + 300,
                1, 0,
                0, 0,
                0.50
            );

        for (i = 0; i < 40; i++)
            ShieldRegisterHudElem(
                #"X1" + i,
                self.primaryColor + "_",
                0xFFFFC0EB,
                -199 + i * 10, 85 - 40 + 300,
                1, 0,
                0, 0,
                0.50
            );

        for (i = 0; i < 110; i++)
            ShieldRegisterHudElem(
                #"X2" + i,
                self.primaryColor + "_",
                0xFFFFC0EB,
                -199 + i * 10, 825 - 40 + 300,
                1, 0,
                0, 0,
                0.50
            );
        for (i = 0; i < 35; i++)
            ShieldRegisterHudElem(
                #"Y1" + i,
                self.primaryColor + "|",
                0xFFFFC0EB,
                199, 105 + i * 20 - 40 + 300,
                1, 0,
                0, 0,
                0.50
            );

        for (i = 0; i < 37; i++)
            ShieldRegisterHudElem(
                #"Y2" + i,
                self.primaryColor + "|",
                0xFFFFC0EB,
                -202, 105 + i * 20 - 40 + 300,
                1, 0,
                0, 0,
                0.50
            );

        for (i = 0; i < 2; i++)
            ShieldRegisterHudElem(
                #"Y3" + i,
                self.primaryColor + "|",
                0xFFFFC0EB,
                899, 805 + i * 20 - 40 + 300,
                1, 0,
                0, 0,
                0.51
            );
        for (i = 0; i < 32; i++) ShieldHudElemSetText(#"TitleBar" + i, self.primaryColor + "_");
        for (i = 0; i < 32; i++) ShieldHudElemSetText(#"FooterBar" + i, self.primaryColor + "_");
        for (i = 0; i < 32; i++) ShieldHudElemSetText(#"X1" + i, self.primaryColor + "_");
        for (i = 0; i < 32; i++) ShieldHudElemSetText(#"X2" + i, self.primaryColor + "_");
        for (i = 0; i < 35; i++) ShieldHudElemSetText(#"Y1" + i, self.primaryColor + "|");
        for (i = 0; i < 32; i++) ShieldHudElemSetText(#"Y2" + i, self.primaryColor + "|");
        for (i = 0; i < 2;  i++) ShieldHudElemSetText(#"Y3" + i, self.primaryColor + "|");
    }
    ShieldRegisterHudElem(
        #"Header",
        "",
        0xFFFFC0EB,
        self.Left, self.Top - 15 + 300,
        2, 1,
        1, 1,
        0.6
    );
    self.Top += self.tsize;
}

DoHeartText()
{
    self endon("stop_doheart");
    hudElemName = "DoHeart";

    x = -2290;
    y = 60;
    minFontSize = 0.5;
    maxFontSize = 2.0;
    fontSize = minFontSize;
    fontSizeSpeed = 0.1;

    ShieldRegisterHudElem(
        hudElemName,
        "",
        0xFFFFC0EB,
        x, y,
        2, 1,
        1, 1,
        1
    );

    while (isDefined(self.DoHeart))
    {
        fontSize = fontSize + fontSizeSpeed;

        if (fontSize >= maxFontSize || fontSize <= minFontSize)
        {
            fontSizeSpeed = fontSizeSpeed * -1;
        }

        ShieldRegisterHudElem(
            hudElemName,
            "",
            0xFFFFC0EB,
            x, y,
            2, 1,
            1, 1,
            fontSize
        );

        ShieldHudElemSetText(hudElemName, self.primaryColor + "Shield " + self.secondaryColor + "<3");

        wait 0.05;
    }
}

BouncingText()
{
    self endon("stop_bounce");
    hudElemName = "BouncingText";

    x = -530;
    y = 0;
    xSpeed = 5;
    ySpeed = 3;
    maxX = -1150;
    maxY = 95;

    minX = -1 * maxX;
    minX = minX + 50;
    minY = -1 * maxY;
    minY = minY + 50;

    ShieldRegisterHudElem(
        hudElemName,
        "",
        0xFFFFC0EB,
        x, y,
        2, 1,
        1, 1,
        1
    );

    while (isDefined(self.DVDText))
    {
        x = x + xSpeed;
        y = y + ySpeed;

        if (x >= maxX)  
        {
            xSpeed = xSpeed * -1;
        }
        if (x <= minX)  
        {
            xSpeed = xSpeed * -1;
        }

        if (y >= maxY)  
        {
            ySpeed = ySpeed * -1;
        }
        if (y <= minY)  
        {
            ySpeed = ySpeed * -1;
        }

        ShieldRegisterHudElem(
            hudElemName,
            "",
            0xFFFFC0EB,
            x, y,
            2, 1,
            1, 1,
            0.5
        );

        ShieldHudElemSetText(hudElemName, self.primaryColor + "Shield Menu " + self.secondaryColor + "v1.0");

        wait 0.05;
    }
}

ScrollingTextHUD()
{
        self endon("menu_closed");

        hudElemName = "ScrollingText";
        
        x = -820;
        y = 67 + 300;
        speed = 5;
        maxX = -695;
        
        textArray = [];
        textArray[0] = self.secondaryColor + "^BHUD_OBIT_DEATH_SUICIDE^ Shoot ";
        textArray[1] = self.primaryColor + "= down | ";
        textArray[2] = self.secondaryColor + "Aim ";
        textArray[3] = self.primaryColor + "= up | ";
        textArray[4] = self.secondaryColor + "Reload ";
        textArray[5] = self.primaryColor + "= select | ";
        textArray[6] = self.secondaryColor + " ^BHUD_OBIT_KNIFE^ Melee ";
        textArray[7] = self.primaryColor + "= back";

        totalParts = textArray.size;
        visibleParts = totalParts;

        ShieldRegisterHudElem(
            hudElemName,
            "",
            0xFFFFC0EB,
            x, y,
            2, 1,
            1, 1,
            0.1
        );

        while (true)
        {
            x = x + speed;

            if (x >= maxX)
            {
                visibleParts--;

                if (visibleParts <= 0)
                {
                    x = -870;
                    visibleParts = 0;
                }
            }
            else if (x <= -870 + (totalParts * 20))
            {
                visibleParts++;
                if (visibleParts > totalParts)
                {
                    visibleParts = totalParts;
                }
            }

            displayText = "";
            for (i = 0; i < visibleParts; i++)
            {
                displayText = displayText + textArray[i];
            }

            ShieldRegisterHudElem(
                hudElemName,
                "",
                0xFFFFC0EB,
                x, y,
                2, 1,
                1, 1,
                0.45
            );

            ShieldHudElemSetText(hudElemName, displayText);

            wait 0.05;
        }
}

UpdateRoundHUD(round)
{
    xStart = -530;
    yStart = 480;
    xEnd = -1150;
    yEnd = -50;

    self.TextSize = 1;
    ShieldRegisterHudElem(
        #"Round",
        "",
        0,
        xStart, yStart,
        2, 1,
        1, 1,
        self.TextSize
    );
    ShieldHudElemSetText(#"Round", "^1Round: " + round);

    MoveRoundHUD(xStart, yStart, xEnd, yEnd, 1, 3);

    wait 3;

    MoveRoundHUD(xEnd, yEnd, xStart, yStart, 3, 1);
}

MoveRoundHUD(x1, y1, x2, y2, sizeStart, sizeEnd)
{
    time = 0.1;
    steps = 30;
    waitTime = time / steps;

    for(i = 0; i <= steps; i++)
    {
        x = x1 + ((x2 - x1) * i) / steps;
        y = y1 + ((y2 - y1) * i) / steps;
        self.TextSize = sizeStart + ((sizeEnd - sizeStart) * i) / steps;

        ShieldRegisterHudElem(
            #"Round", 
            "",
            0, 
            x, y,
            2, 1, 
            1, 1,
            self.TextSize
        );

        ShieldHudElemSetText(#"Round", "^1Round " + level.currentRound);
        wait waitTime;
    }
}

PointsHUD()
{
    x = -507;
    y = 525;

    ShieldRegisterHudElem(
        #"Points",
        "",
        0,
        x, y,
        2, 1,
        1, 1,
        0.7
    );

    while (true)
    {
        formattedPoints = FormatPoints(self.points);
        
        ShieldHudElemSetText(#"Points", "^2Points: ^3" + formattedPoints);
        wait 0.1;
    }
}

AddPointsHUD(points)
{
    sizeStart = 0.1;
    sizeEnd = 1;

    xBase = -500;
    yBase = -50;

    xOffset = RandomIntRange(-70, 70);
    yOffset = RandomIntRange(-70, 70);

    x = xBase + xOffset;
    y = yBase + yOffset;

    uniqueHUDName = "AddPoints_" + randomInt(999999) + "_" + level.time;

    ShieldRegisterHudElem(
        #uniqueHUDName,
        "",
        0,
        x, y,
        2, 1,
        1, 1,
        sizeStart
    );

    ShieldHudElemSetText(#uniqueHUDName, "^3+ " + points);

    steps = 10;
    for (i = 0; i <= steps; i++)
    {
        size = sizeStart + ((sizeEnd - sizeStart) * i) / steps;
        ShieldHudElemSetScale(#uniqueHUDName, size);
        wait 0.03;
    }

    wait 0.5;

    for (i = 0; i <= steps; i++)
    {
        size = sizeEnd - ((sizeEnd - sizeStart) * i) / steps;
        ShieldHudElemSetScale(#uniqueHUDName, size);
        wait 0.05;
    }

    ShieldHudElemSetText(#uniqueHUDName, "");
}

CountdownHUD()
{
    x = -1150;
    y = -80;

    ShieldRegisterHudElem(
        #"Countdown",
        "",
        0,
        x, y,
        2, 1,
        1, 1,
        2
    );
}

ClearMenuHUDs(){
    ShieldRemoveHudElem(#"Header");
    ShieldRemoveHudElem(#"Footer");
    ShieldRemoveHudElem("ScrollingText");
    ShieldRemoveHudElem("BouncingText");

    for (i = 0; i < 100; i++) ShieldRemoveHudElem("MenuLine" + i);
    for (i = 0; i < 100; i++) ShieldRemoveHudElem(#"TitleBar" + i);
    for (i = 0; i < 120; i++) ShieldRemoveHudElem(#"FooterBar" + i);
    for (i = 0; i < 120; i++) ShieldRemoveHudElem(#"X1" + i);
    for (i = 0; i < 120; i++) ShieldRemoveHudElem(#"X2" + i);
    for (i = 0; i < 100; i++) ShieldRemoveHudElem(#"Y1" + i);
    for (i = 0; i < 100; i++) ShieldRemoveHudElem(#"Y2" + i);
    for (i = 0; i < 100; i++) ShieldRemoveHudElem(#"Y3" + i);
}

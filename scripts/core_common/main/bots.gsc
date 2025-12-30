AddBotsToGame(Amount)
{
    BotTeams = array(
        #"axis", 
        #"allies"
    );

    BotNames = array(
        "xXGhostXx", "V1p3r", "R0gu3", "Reap3r_99", "Sh4d0w",
        "H4v0c", "Str1k3r", "Bulle7", "Fr0stBite", "V3n0mX",
        "B1aze", "Rapt0r_77", "Hunt3rX", "C0brA", "Ph03n1x",
        "DrakeXx", "F4lc0n", "St0rm99", "Tit4n_21", "Mav3rickX",
        "Band1t_OG", "Kn0x", "N0vaX", "Ra1der77", "EchoX"
    );

    BotClans = array(
        "xTrM", "FuRyX", "sN1P", "BoTz", "W0Lf",
        "RaG3", "T4NK", "eL1T", "N0Va", "K1LL",
        "HnTz", "R3Ap", "STLM", "V0ID", "F1RE",
        "D4RK", "L10N", "VPRx", "STYX", "GLXY",
        "B4ND", "KNXT", "R41D", "PHNX", "BR5K"
    );

    self.BotsInGame = array();

    for (i = 0; i < int(Amount); i++) {
        team = BotTeams[randomint(BotTeams.size)];
        clan = BotClans[randomint(BotClans.size)];
        name = BotNames[randomint(BotNames.size)];
        
        Bot = bot::add_bot(team, clan, name);
        self.BotsInGame[i] = Bot;
        wait 0.2;
    }
}
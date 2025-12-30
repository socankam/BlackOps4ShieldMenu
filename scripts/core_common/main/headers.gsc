#include scripts\core_common\struct;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\player\player_role;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\values_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\vehicle_shared.gsc;
#include scripts\core_common\rank_shared.gsc;
#include scripts\core_common\visionset_mgr_shared.gsc;

#using scripts\core_common\aat_shared;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\animation_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\ai\systems\ai_interface.gsc;

#namespace blackops4menu;

autoexec __init__system__() {

	system::register("blackops4menu", &__init__, undefined);

    level.CurrentMap = CurrentMapName();

    SetupGameSettings();
    SetGametypeSettings();
    InitVars();
}

__init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&onPlayerConnect);
    callback::on_spawned(&onPlayerSpawned);

    level.var_8dcd4dc8 = [];
}

SetupGameSettings(){
    self.HUD = false; //Change to true for HUD (Box Elem menu)
    self.GameSettings = undefined;

    // Blackout Settings
    if(Blackout()){
        self.GameSettings["Enable Respawns"] = true;
        self.GameSettings["Number Of Lives"] = 5;
        self.GameSettings["Respawn Delay"] = 5;
        self.GameSettings["Enable Blackjack"] = false;
        self.GameSettings["Max Amount Of Zombies"] = 999;
        self.GameSettings["Enable Blackjack"] = true;
        self.GameSettings["Enable Snowballs"] = false;
        self.GameSettings["Enable Water Balloons"] = false;

        self.GameSettings["Enable Armor"] = true;
        self.GameSettings["Enable Attachments"] = true;
        self.GameSettings["Enable Health Items"] = true;

        self.GameSettings["Allow Only Headshots"] = false;

        //Leave these as they are if you plan on playing custom zombies. Custom zombies can only be played on Nuketown, or the Night time blackout alcatraz map.
        self.GameSettings["Enable Storm"] = false;
        self.GameSettings["Enable Perks"] = false;
    }

    //Multiplayer Settings
    if(Multiplayer()){
        self.GameSettings["Draft Time"] = 5;
    }

    //Zombie Settings
    if(Zombies()){
        //
    }
}

InitVars(){
    //
}
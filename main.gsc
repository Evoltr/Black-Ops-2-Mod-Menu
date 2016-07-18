#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
    precacheModel("projectile_hellfire_missile"):
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        if (player isHost())
             player.status = "Host";
        else
            player.status = "Not verified";
            
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	self freezecontrols(false);
	self.MenuInit = false;
    for(;;)
    {
        self waittill("spawned_player");
		if (!self.MenuInit)
		{
		self.MenuInit = true
		self thread welcomeMessage
		}
    }
    
welcomeMessage()
{
	notifyData = spawnstruct();
	notifyData.titleText = "^5Welcome to Cerberus V1";
	notifyData.glowColor = (0.5, 0.2, 1);
	notifyData.duration = 7;
	notifyData.font = "hudbig";
	notifyData.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}
}


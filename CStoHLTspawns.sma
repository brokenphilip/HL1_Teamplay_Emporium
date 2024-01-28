#include <amxmodx>
#include <engine>
#include <fakemeta>

#define VERSION "1.0"

new gTeam[2][64];

public plugin_init()
{
	register_plugin("CS to HL Teamplay Spawns", VERSION, "brokenphilip");
	
	new teamplay = get_cvar_num("mp_teamplay");
	if (teamplay != 1)
	{
		log_amx("Teamplay not enabled - skipping...");
		return;
	}
	
	new team_list[256];
	get_cvar_string("mp_teamlist", team_list, 256);
	
	new team_count = CharsInString(team_list, ';') + 1;
	if (team_count != 2)
	{
		log_amx("Found %d teams in mp_teamlist, expected 2 - skipping...", team_count);
		return;
	}

	strtok(team_list, gTeam[0], 63, gTeam[1], 63, ';', 0);
	log_amx("Found two teams: %s and %s.", gTeam[0], gTeam[1]);
	
	// Create team masters
	new ent = create_entity("game_team_master");
	set_pev(ent, pev_targetname, gTeam[0]);
	DispatchKeyValue(ent, "teamindex", "0");
	ent = create_entity("game_team_master");
	set_pev(ent, pev_targetname, gTeam[1]);
	DispatchKeyValue(ent, "teamindex", "1");
	
	// Normal spawns used by HLDM / Terrorist spawns
	new target = -1;
	new count = 0;
	while ((target = find_ent_by_class(target, "info_player_deathmatch")))
	{
		if (pev_valid(target))
		{
			count++;
			set_pev(target, pev_netname, gTeam[1]);
		}
	}
	
	// Normal spawns used by HLSP / Counter-Terrorist spawns
	target = -1;
	count = 0;
	while ((target = find_ent_by_class(target, "info_player_start")))
	{
		if (pev_valid(target))
		{
			count++;
			new Float:origin[3], Float:angles[3];
			pev(target, pev_origin, origin);
			pev(target, pev_angles, angles);
			
			new ent = create_entity("info_player_deathmatch");
			set_pev(ent, pev_netname, gTeam[0]);
			set_pev(ent, pev_origin, origin);
			set_pev(ent, pev_angles, angles);
		}
	}
	
	log_amx("Created %d spawns for team %s.", count, gTeam[0]);
	log_amx("Created %d spawns for team %s.", count, gTeam[1]);
}

CharsInString(string[], character)
{
	new total, i, c;
	
	while ((c = string[i++]))
	{
		total += _:(c == character)
	}
    
	return total;
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1033\\ f0\\ fs16 \n\\ par }
*/

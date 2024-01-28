#include <amxmodx>
#include <fakemeta>
#include <hlstocks>

#define VERSION "1.0"

#define MAX_TEAMS		32
#define MAX_TEAMNAME		16

new _msgVGUIMenu;
new _is_teamplay = 0;

new _teamNames[MAX_TEAMS][MAX_TEAMNAME + 1];
new _teams;

public plugin_precache()
{
	_msgVGUIMenu = engfunc(EngFunc_RegUserMsg, "VGUIMenu", 1);
}

public plugin_init()
{
	_is_teamplay = get_cvar_num("mp_teamplay");
	
	register_plugin("Team Menu", VERSION, "brokenphilip, KORD_12.7, Lev");
	
	if (_is_teamplay)
	{
		get_team_names();
		register_clcmd("jointeam", "clcmd_jointeam");
	}
}

public clcmd_jointeam(id)
{
	if (read_argc() < 1)
	{
		return;
	}
	
	new team = read_argv_int(1);
	if (team >= 1 && team <= 4)
	{
		join_team(id, team);
	}
	else if (team == 5)
	{
		join_team_auto(id);
	}
}

public client_putinserver(id)
{
	if (_is_teamplay && !is_user_bot(id))
	{
		set_task(0.1, "task_putinserver", id);
	}
}

public task_putinserver(id)
{
	hl_set_user_spectator(id, true);
	open_team_menu(id);
}

join_team(id, team)
{
	if (team > get_team_count())
	{
		return;
	}
	
	engfunc(EngFunc_SetClientKeyValue, id, engfunc(EngFunc_GetInfoKeyBuffer, id), "model", _teamNames[team - 1]);
	hl_set_user_spectator(id, false);
}

join_team_auto(id)
{
	new players[32], count = 0;
	get_players(players, count);
	
	new min_players = 32;
	new min_team = 1;
	
	for (new team = 1; team < get_team_count(); team++)
	{
		new team_count = 0;
		
		for (new i = 0; i < count; i++)
		{
			if (get_user_team(players[i]) == team)
			{
				team_count++;
			}
		}
		
		if (team_count < min_players)
		{
			min_players = team_count;
			min_team = team;
		}
	}
	
	engfunc(EngFunc_SetClientKeyValue, id, engfunc(EngFunc_GetInfoKeyBuffer, id), "model", _teamNames[min_team - 1]);
	hl_set_user_spectator(id, false);
}

open_team_menu(id)
{
	engfunc(EngFunc_MessageBegin, MSG_ONE, _msgVGUIMenu, 0, id);
	write_byte(2);
	message_end();
}

get_team_count()
{
	new team_list[256];
	get_cvar_string("mp_teamlist", team_list, 256);
	return chars_in_string(team_list, ';') + 1;
}

chars_in_string(string[], character)
{
	new total, i, c;
	
	while ((c = string[i++]))
	{
		total += _:(c == character)
	}
    
	return total;
}

get_team_names()
{
	new j, teams[MAX_TEAMS * MAX_TEAMNAME + 1], team[MAX_TEAMNAME + 1];
	get_cvar_string("mp_teamlist", teams, charsmax(teams));
	for (j = 0; j < MAX_TEAMS; j++)
	{
		strtok(teams, team, charsmax(team), teams, charsmax(teams), ';');
		if (team[0] == 0) break;
		copy(_teamNames[j], MAX_TEAMNAME, team);
		_teams++;
	}
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1033\\ f0\\ fs16 \n\\ par }
*/

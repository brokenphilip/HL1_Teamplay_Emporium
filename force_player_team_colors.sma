#include <amxmodx>
#include <amxmisc>
#include <fakemeta>

#define VERSION "1.0"

public plugin_init()
{
	register_plugin("Force Player Team Colors", VERSION, "brokenphilip");
	
	if (get_cvar_num("mp_teamplay"))
	{
		register_forward(FM_ClientUserInfoChanged, "info_changed");
	}
}

public info_changed(id)
{
	new color = 0;

	switch ((get_user_team(id) - 1) % 5)
	{
		case 0: // blue
		{
			color = 170;
		}
		
		case 1: // red
		{
			color = 0;
		}
		
		case 2: // yellow
		{
			color = 43;
		}
		
		case 3: // green
		{
			color = 85;
		}
		
		case 4: // orange
		{
			color = 21;
		}
	}
	
	new s_color[4];
	num_to_str(color, s_color, 3);
	
	engfunc(EngFunc_SetClientKeyValue, id, engfunc(EngFunc_GetInfoKeyBuffer, id), "topcolor", s_color);
	engfunc(EngFunc_SetClientKeyValue, id, engfunc(EngFunc_GetInfoKeyBuffer, id), "bottomcolor", s_color);
} 
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1033\\ f0\\ fs16 \n\\ par }
*/

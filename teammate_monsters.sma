#include <amxmodx>
#include <amxmisc>
#include <hamsandwich>
#include <fakemeta>

#define VERSION "1.0"

// monster to monster relationship types (from monsters.h)
#define R_AL	-2	// (ALLY) pals. Good alternative to R_NO when applicable.
#define R_FR	-1	// (FEAR) will run
#define	R_NO	 0	// (NO RELATIONSHIP) disregard
#define R_DL	 1	// (DISLIKE) will attack
#define R_HT	 2	// (HATE) will attack this character instead of any visible DISLIKED characters
#define R_NM	 3	// (NEMESIS) A monster Will ALWAYS attack its nemsis, no matter what

new _mp_friendlyfire;
new _tmm_hornets, _tmm_snarks, _tmm_friendlyfire;

public plugin_init()
{
	register_plugin("Teammate Monsters", VERSION, "brokenphilip")
	
	if (get_cvar_num("mp_teamplay"))
	{
		RegisterHam(Ham_IRelationship, "hornet", "CHornet_IRelationship");
		RegisterHam(Ham_IRelationship, "monster_snark", "CSqueakGrenade_IRelationship");
		
		_mp_friendlyfire = register_cvar("mp_friendlyfire", "");
		
		// Allow this plugin to work for hornets
		_tmm_hornets = register_cvar("tmm_hornets", "1");
		
		// Allow this plugin to work for snarks
		_tmm_snarks = register_cvar("tmm_snarks", "1");
		
		// Allow this plugin to work when friendly fire is enabled
		_tmm_friendlyfire = register_cvar("tmm_friendlyfire", "1");
	}
}

public CHornet_IRelationship(this, other)
{
	if (!get_pcvar_bool(_tmm_hornets))
	{
		return HAM_IGNORED;
	}
	
	new owner = pev(this, pev_owner);
	if (!owner)
	{
		owner = -1;
	}
	
	return monster_relationship(owner, other);
}

public CSqueakGrenade_IRelationship(this, other)
{
	if (!get_pcvar_bool(_tmm_snarks))
	{
		return HAM_IGNORED;
	}
	
	return monster_relationship(get_ent_data_entity(this, "CSqueakGrenade", "m_hOwner"), other);
}

monster_relationship(owner, other)
{
	// if friendly fire is enabled, check if we're allowed to run first
	if (get_pcvar_bool(_mp_friendlyfire) && !get_pcvar_bool(_tmm_friendlyfire))
	{
		return HAM_IGNORED;
	}
	
	// if other entity is a player on the same team as this monster's owner, don't attack
	// if other entity is this monster's owner (ie. self-damage), let the game handle it
	if (is_user_connected(owner) && is_user_connected(other) && owner != other && get_user_team(owner) == get_user_team(other))
	{
		SetHamReturnInteger(R_AL);
		return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;	
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1033\\ f0\\ fs16 \n\\ par }
*/

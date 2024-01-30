# Half-Life 1 Teamplay Emporium
An assorted collection of AMX Mod X plugins for Half-Life 1 which enhance the Teamplay experience.

All of the plugins in this repository have either been created or modified by me. If you are an author of one of the plugins listed and you want them updated/taken down or similar, please let me know on Discord (`brokenphilip`) or create an issue.

Check the "See also" section for more plugins not created by me which also enhance team gameplay.

## Plugins
All of the plugins in this repository are assumed to work on AMX 1.8 unless specified otherwise, but **very little to no support will be provided if you use AMX 1.8**, as these plugins can and will be updated to only support AMX 1.9+ if necessary for its features to work. It is strongly recommended to use the latest master branch (as of writing, AMX 1.10) instead, as these plugins have only been tested on (and are actively being developed for) this version of AMX.

Check each plugin's source code for their respective change logs.

Arguments in `<>` are mandatory, while arguments in `[]` are optional.

### CS to HL Teamplay Spawns v1.0
Allows Counter-Strike 1.6 maps to be played for Half-Life Teamplay by assigning spawns to their respective teams. It will also work for other GoldSrc maps which use `info_player_start` and `info_player_deathmatch` entities for spawn locations.

### Force Player Team Colors v1.1
Forces `topcolor` and `bottomcolor` to match the color of the team.

![image](https://github.com/brokenphilip/HL1_Teamplay_Emporium/assets/13336890/6fed8a3d-955d-40e7-ae0d-5a1d9e7bad06)

### Team Menu v1.0
Opens a team selection VGUI menu when you join the server. Auto assign puts you in the team with the least players. Credits to **KORD_12.7** and **Lev** for the menu itself.

**Commands:**
- `jointeam <num>` - Joins the team number `num`, starting from index 1

![image](https://github.com/brokenphilip/HL1_Teamplay_Emporium/assets/13336890/dec51833-6c8c-4045-8978-6f28ef10692d)

### Teammate Monsters v1.0
**Requires AMX 1.9+**

Prevents monsters created by players (snarks and hornets) from chasing their teammates.

**Cvars:**
- `tmm_friendlyfire <0-1>` - Should this plugin work when `mp_friendlyfire` is enabled (default: `1`)
- `tmm_hornets <0-1>` - Should this plugin work for hornets (default: `1`)
- `tmm_snarks <0-1>` - Should this plugin work for snarks (default: `1`)

## See also
*[todo]*
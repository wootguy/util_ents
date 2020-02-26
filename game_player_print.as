#include "utils"

namespace GamePlayerPrint {

	enum SPECIAL_MESSAGE_TYPES {
		HUD_PRINTKEYBIND = -1
	}
	
	enum SPAWN_FLAGS {
		FL_ALL_PLAYERS = 1
	}

	class game_player_print : ScriptBaseEntity
	{
		int messageType;
		
		bool KeyValue( const string& in szKey, const string& in szValue )
		{	
			if (szKey == "messagetype") messageType = atoi(szValue);
			else return BaseClass.KeyValue( szKey, szValue );
			
			return true;
		}
		
		void Use(CBaseEntity@ pActivator, CBaseEntity@ pCaller, USE_TYPE useType, float flValue = 0.0f)
		{
			if (useType == USE_OFF)
				return;
			
			// calculating flags here since KeyValue ignores 'spawnflags'
			bool allPlayers = self.pev.spawnflags & FL_ALL_PLAYERS != 0;			
			
			if (allPlayers) {
				if (messageType == HUD_PRINTKEYBIND) {
					g_PlayerFuncs.PrintKeyBindingStringAll(self.pev.message);
				} else {
					g_PlayerFuncs.ClientPrintAll(HUD(messageType), string(self.pev.message) + "\n");
				}
			} else {
				array<CBaseEntity@> targets = UtilEnts::getTargetsByName(pActivator, pCaller, self.pev.target);
			
				for (uint i = 0; i < targets.size(); i++) {
					CBasePlayer@ plr = cast<CBasePlayer@>(targets[i]);
					
					if (plr is null or !plr.IsConnected())
						continue;
					
					if (messageType == HUD_PRINTKEYBIND) {
						g_PlayerFuncs.PrintKeyBindingString(plr, self.pev.message);
					} else {
						g_PlayerFuncs.ClientPrint(plr, HUD(messageType), string(self.pev.message) + "\n");
					}
				}
			}
		}

	};

	void Register()
	{
		g_CustomEntityFuncs.RegisterCustomEntity( "GamePlayerPrint::game_player_print", "game_player_print" );
	}
}
#include "game_player_hud_sprite"
#include "game_player_print"
#include "func_throwable"
#include "trigger_radius"

// helper for registering ALL ents.
void RegisterUtilEnts() {
	GamePlayerHudSprite::Register();
	GamePlayerPrint::Register();
	FuncThrowable::Register();
	TriggerRadius::Register();
}
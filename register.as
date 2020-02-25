#include "game_player_hud_sprite"
#include "func_throwable"

// helper for registering ALL ents.
void RegisterUtilEnts() {
	GamePlayerHudSprite::Register();
	FuncThrowable::Register();
}
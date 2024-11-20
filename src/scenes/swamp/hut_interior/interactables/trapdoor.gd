extends BaseEvent

func investigate():
	Utility.msg("Swamp.Hut_Interior.Trapdoor_Look")

func interact():
	if (GameVars.get_var(Enums.Vars.TRAPDOOR_WARNED)):
		await Utility.msg("Swamp.Hut_Interior.Trapdoor_Interact_Pre_Game_Over")
		Utility.initiate_game_over(Enums.Scenes.GAME_OVER_RHODE, 1.5)
	else:
		Utility.msg("Swamp.Hut_Interior.Trapdoor_Interact_Warning")
		GameVars.set_var(Enums.Vars.TRAPDOOR_WARNED, true)

extends BaseEvent

func investigate():
	await Utility.msg("Swamp.Standing_Water.Water_Look", true)
	await Utility.msg("Swamp.Standing_Water.Puffball_Near_Shore", true)
	Utility.msg("Swamp.Standing_Water.Puffball_Look")

func take():
	Utility.initiate_game_over(Enums.Scenes.GAME_OVER_PUFFBALL)

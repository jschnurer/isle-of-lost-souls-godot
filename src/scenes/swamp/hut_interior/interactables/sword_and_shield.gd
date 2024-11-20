extends BaseEvent

func investigate():
	await Utility.msg("Swamp.Hut_Interior.Sword_Look")
	Utility.msg("Swamp.Hut_Interior.Shield_Look")

func take():
	Utility.msg("Swamp.Hut_Interior.Take_No_Permission")

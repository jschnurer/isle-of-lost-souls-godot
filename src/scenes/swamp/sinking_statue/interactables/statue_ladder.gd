extends BaseEvent

func investigate():
	Utility.msg("Swamp.Sinking_Statue.Statue_Ladder_Look")

func interact():
	await Utility.msg("Swamp.Sinking_Statue.Statue_Ladder_Interact")
	Utility.go_to_sub_area(Enums.Scenes.SWAMP_STATUE_TOP)

extends BaseEvent

func investigate():
	Utility.msg("Swamp.Hut_Exterior.Hut_Look")
	
func take():
	Utility.msg("Swamp.Hut_Exterior.Hut_Take")

func interact():
	await Utility.msg("Swamp.Hut_Exterior.Hut_Interact")
	# TODO: GO INSIDE HUT

extends BaseEvent

func investigate():
	await Utility.msg("Forest.Bend.Sack_Look")
	Utility.go_to_sub_area(Enums.Scenes.FOREST_BEND_SACK)
	
func take():
	Utility.msg("Forest.Bend.Sack_Take")

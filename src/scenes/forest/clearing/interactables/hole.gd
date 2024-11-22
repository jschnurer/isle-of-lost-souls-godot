extends BaseEvent

func investigate():
	await Utility.msg("Forest.Clearing.Hole_Look")
	Utility.go_to_sub_area(Enums.Scenes.FOREST_CLEARING_HOLE)

func take():
	Utility.msg("Forest.Clearing.Hole_Take")

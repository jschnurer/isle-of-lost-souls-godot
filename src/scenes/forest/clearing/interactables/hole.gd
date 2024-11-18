extends BaseEvent

func investigate():
	await Utility.show_message(GameScript.get_entry("Forest.Clearing.Hole_Look"))
	Utility.go_to_sub_area(Enums.Scenes.FOREST_CLEARING_HOLE)

func take():
	Utility.show_message(GameScript.get_entry("Forest.Clearing.Hole_Take"))

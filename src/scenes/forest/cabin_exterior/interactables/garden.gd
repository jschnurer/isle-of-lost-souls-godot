extends "res://src/events/game_event/base_event.gd"

func investigate():
	Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Garden_Look"))

func take():
	Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Garden_Take"))

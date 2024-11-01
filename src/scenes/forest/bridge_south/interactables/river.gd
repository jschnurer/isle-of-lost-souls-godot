extends "res://src/events/game_event/base_event.gd"

func investigate():
	Utility.show_message(GameScript.get_entry("Forest.Bridge_South.River_Look"))

func take():
	Utility.show_message(GameScript.get_entry("Forest.Bridge_South.River_Take"))

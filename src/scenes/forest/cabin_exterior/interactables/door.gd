extends "res://src/events/game_event/base_event.gd"

func investigate():
	Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Door_Look"))

func interact():
	# TODO: HANDLE DOOR
	Utility.show_message("TODO: TELEPORT PLAYER INSIDE IF ARDEN IS OK WITH IT")
	

extends "res://src/events/game_event/base_event.gd"

func investigate():
	Utility.show_message(GameScript.Forest_Clearing_Dirt_Look)

func take():
	Utility.show_message(GameScript.Forest_Clearing_Dirt_Take)

func interact():
	Utility.show_message(GameScript.Global_No_Mechanism_To_Interact)

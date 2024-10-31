extends "res://src/events/game_event/base_event.gd"

func investigate():
	Utility.show_message(GameScript.Forest_Bridge_South_River_Look)

func take():
	Utility.show_message(GameScript.Forest_Bridge_South_River_Take)

func interact():
	Utility.show_message(GameScript.Global_No_Mechanism_To_Interact)

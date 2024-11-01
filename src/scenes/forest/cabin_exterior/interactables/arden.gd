extends "res://src/events/game_event/base_event.gd"

func investigate():
	Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Arden_Look"), true)
	Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Arden_Look_2"))

func interact():
	await Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Arden_Interact"))
	var choice = await Utility.show_yes_no_choice()
	
	if (choice.index == 1):
		await Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Arden_No_Nail"))
	else:
		await Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Arden_Lie_About_Nail"))

func take():
	Utility.show_message(GameScript.get_entry("Forest.Cabin_Exterior.Arden_Take"))

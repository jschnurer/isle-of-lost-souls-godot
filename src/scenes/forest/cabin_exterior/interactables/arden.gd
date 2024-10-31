extends "res://src/events/game_event/base_event.gd"

func investigate():
	await Utility.show_message(GameScript.Forest_Cabin_Exterior_Arden_Look, true)
	Utility.show_message(GameScript.Forest_Cabin_Exterior_Arden_Look_2)

func interact():
	await Utility.show_message(GameScript.Forest_Cabin_Exterior_Arden_Interact, false)
	var choice = await Utility.show_choice([GameScript.Global_Yes, GameScript.Global_No], 1)
	
	if (choice.index == 1):
		await Utility.show_message(GameScript.Forest_Cabin_Exterior_Arden_No_Nail, false)
	else:
		pass

func take():
	Utility.show_message(GameScript.Forest_Cabin_Exterior_Arden_Take)

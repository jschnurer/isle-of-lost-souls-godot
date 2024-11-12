extends Node2D

func _ready():
	await Utility.fade_in(false, .33)
	
	await Utility.wait(2)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Fish.Fish_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Fish.Fish_2"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Fish.Fish_3"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Fish.Fish_4"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Fish.Fish_5"))
	
	await Utility.wait(1)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Fish.Fish_6"))
	
	await Utility.fade_out(false, .5)

	SignalBus.return_to_title_screen.emit()

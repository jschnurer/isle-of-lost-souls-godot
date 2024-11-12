extends Node2D

func _ready():
	await Utility.fade_in(false, .33)
	
	await Utility.wait(2)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_2"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_3"))
	
	await Utility.wait(1)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_4"))
	
	await Utility.wait(2)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Mushroom.Mushroom_5"))
	
	await Utility.fade_out(false, .5)
	
	SignalBus.return_to_title_screen.emit()

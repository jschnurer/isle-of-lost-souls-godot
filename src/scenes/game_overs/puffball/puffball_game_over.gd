extends Node2D

func _ready():
	await Utility.fade_in(false, .33)
	
	await Utility.wait(2)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Puffball.Puffball_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Puffball.Puffball_2"), false)
	
	await Utility.wait(1)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Puffball.Puffball_3"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Puffball.Puffball_4"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Puffball.Puffball_5"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Puffball.Puffball_6"))
	
	await Utility.wait(2)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Puffball.Puffball_7"))
	
	await Utility.fade_out(false, .5)
	
	SignalBus.return_to_title_screen.emit()

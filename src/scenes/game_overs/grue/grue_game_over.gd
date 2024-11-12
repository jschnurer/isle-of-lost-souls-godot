extends Node2D

func _ready():
	await Utility.fade_in(false, .33)
	
	await Utility.wait(2)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_2"))
	
	await Utility.wait(1)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_3"))
	
	await Utility.fade_out(false, .5)

	SignalBus.return_to_title_screen.emit()

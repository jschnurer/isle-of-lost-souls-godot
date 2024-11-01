extends Node2D

func _ready():
	var fade_args = ScreenFadeArgs.new()
	fade_args.color = Color.BLACK
	fade_args.speed_scale = .33
	SignalBus.fade_in_screen.emit(fade_args)
	await SignalBus.fade_in_screen_finished
	
	await Utility.wait(2)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_1"), true)
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_2"))
	
	await Utility.wait(1)
	
	await Utility.show_message(GameScript.get_entry("Game_Overs.Grue.Grue_3"))
	
	SignalBus.return_to_title_screen.emit()

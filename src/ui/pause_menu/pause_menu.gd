extends Node2D

func _ready():
	SignalBus.open_pause_menu.connect(_on_open_pause_menu)

func _on_open_pause_menu():
	Utility.pause()
	
	var choices: Array[String] = [
		GameScript.get_entry("Global.Inventory"),
		GameScript.get_entry("Global.Continue"),
		GameScript.get_entry("Global.Return_Main_Menu"),
		GameScript.get_entry("Global.Quit"),
	]
	
	var choice = await Utility.show_choice(choices, 1)
	Utility.pause()
	
	if (choice.index == 0):
		Utility.unpause()
		SignalBus.open_inventory.emit(Enums.InventoryMode.INVENTORY)
	elif (choice.index == 2):
		confirm_quit(true)
	elif (choice.index == 3):
		confirm_quit(false)
	else:
		Utility.unpause()

func confirm_quit(to_main_menu: bool):
	await Utility.msg("Global.Quit_Prompt")
	var choice = await Utility.show_yes_no_choice()
	
	if (choice.index == 0):
		if (to_main_menu):
			await Utility.fade_out()
			Utility.unpause()
			SignalBus.return_to_title_screen.emit()
		else:
			get_tree().quit()
	else:
		Utility.unpause()

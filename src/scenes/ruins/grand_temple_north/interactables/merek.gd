extends BaseEvent

@export var dialog: BaseDialog

func investigate():
	await Utility.show_message(GameScript.get_entry("Ruins.Temple_North.Marek_Look_1"), true)
	Utility.show_message(GameScript.get_entry("Ruins.Temple_North.Marek_Look_2"))

func take():
	Utility.show_message(GameScript.get_entry("Ruins.Temple_North.Marek_Take"))

func interact():
	Utility.open_dialog(dialog)

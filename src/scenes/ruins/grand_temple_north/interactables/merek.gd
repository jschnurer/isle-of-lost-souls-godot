extends BaseEvent

@export var dialog: BaseDialog

func investigate():
	await Utility.msg("Ruins.Temple_North.Marek_Look_1", true)
	Utility.msg("Ruins.Temple_North.Marek_Look_2")

func take():
	Utility.msg("Ruins.Temple_North.Marek_Take")

func interact():
	Utility.open_dialog(dialog)

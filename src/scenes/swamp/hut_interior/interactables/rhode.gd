extends BaseEvent

@onready var dialog: BaseDialog = $RhodeDialog

func investigate():
	await Utility.msg("Swamp.Hut_Interior.Rhode_Look", true)
	Utility.msg("Swamp.Hut_Interior.Rhode_Look_2")

func interact():
	if (not GameVars.get_var(Enums.Vars.GREETED_RHODE)):
		do_greeting()
	else:
		await Utility.msg("Swamp.Hut_Interior.Rhode_Greet_Again")
		SignalBus.open_dialog_manager.emit(dialog)

func use_item(item: Item):
	if (not GameVars.get_var(Enums.Vars.CAN_GIVE_TO_RHODE)):
		Utility.msg("Swamp.Hut_Interior.Rhode_Give_Not_Yet")
	else:
		# TODO: GIVE ITEMS TO RHODE
		print(item)

func do_greeting():
	await Utility.msg("Swamp.Hut_Interior.Rhode_Greet_1", true)
	await Utility.msg("Swamp.Hut_Interior.Rhode_Greet_2")
	var choice: Choice = await Utility.show_yes_no_choice()
	
	if (choice.index == 0):
		# The player wants to harm Rhode!
		await Utility.msg("Swamp.Hut_Interior.Rhode_Wrong_Answer")
		Utility.initiate_game_over(Enums.Scenes.GAME_OVER_RHODE, 2)
	else:
		await Utility.msg("Swamp.Hut_Interior.Rhode_Greet_3")
		SignalBus.open_dialog_manager.emit(dialog)

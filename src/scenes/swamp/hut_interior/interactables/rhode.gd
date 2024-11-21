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
		if (item.slug == Enums.ItemSlugs.RED_FABRIC):
			await Utility.msg("Swamp.Hut_Interior.Rhode_Red_Fabric_1", true)
			await Utility.msg("Swamp.Hut_Interior.Rhode_Red_Fabric_2", true)
			await Utility.msg("Swamp.Hut_Interior.Rhode_Red_Fabric_3", true)
			await Utility.msg("Swamp.Hut_Interior.Rhode_Red_Fabric_4", true)
			await Utility.msg("Swamp.Hut_Interior.Rhode_Red_Fabric_5", true)
			Utility.msg("Swamp.Hut_Interior.Rhode_Red_Fabric_6")
			Utility.learn_topic(Enums.TopicGroups.GLOBAL, Enums.Topics.OPHELIA)

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
		GameVars.set_var(Enums.Vars.CAN_GIVE_TO_RHODE, true)
		Utility.learn_topic(Enums.TopicGroups.GLOBAL, Enums.Topics.RHODE)
		SignalBus.open_dialog_manager.emit(dialog)

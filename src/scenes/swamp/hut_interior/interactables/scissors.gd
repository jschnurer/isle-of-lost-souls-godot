extends BaseEvent

func investigate():
	Utility.msg("Swamp.Hut_Interior.Scissors_Look")
	Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.GLASS_SCISSORS)

func take():
	if (GameVars.get_var(Enums.Vars.TAKE_SCISSORS_PERMISSION)):
		await Utility.msg("Swamp.Hut_Interior.Scissors_Take")
		GameVars.set_var(Enums.Vars.TOOK_SCISSORS, true)
		Inventory.add_item(Enums.ItemSlugs.SCISSORS)
	else:
		Utility.msg("Swamp.Hut_Interior.Take_No_Permission")

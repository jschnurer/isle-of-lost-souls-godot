extends BaseDialog

func on_greet():
	if (not GameVars.get_var(Enums.Vars.GREETED_RHODE)):
		Utility.dialog_msg("Dialog.Rhode.Greet_First_Time")
		GameVars.set_var(Enums.Vars.GREETED_RHODE, true)
	else:
		Utility.dialog_msg("Dialog.Rhode.Greet_Again")

func ask_about(topic: Enums.Topics):
	if (topic == Enums.Topics.WHO_ARE_YOU):
		await Utility.dialog_msg("Dialog.Rhode.Who_Are_You_1", true)
		Utility.dialog_msg("Dialog.Rhode.Who_Are_You_2")
		Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.MY_PAST)
	
	elif (topic == Enums.Topics.MY_PAST):
		await Utility.dialog_msg("Dialog.Rhode.My_Past_1", true)
		await Utility.dialog_msg("Dialog.Rhode.My_Past_2", true)
		await Utility.dialog_msg("Dialog.Rhode.My_Past_3", true)
		await Utility.dialog_msg("Dialog.Rhode.My_Past_4", true)
		await Utility.dialog_msg("Dialog.Rhode.My_Past_5", true)
		await Utility.dialog_msg("Dialog.Rhode.My_Past_6", true)
		await Utility.dialog_msg("Dialog.Rhode.My_Past_7", true)
		await Utility.dialog_msg("Dialog.Rhode.My_Past_8", true)
		Utility.dialog_msg("Dialog.Rhode.My_Past_9")
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.ISLAND_ARRIVAL)
		
	elif (topic == Enums.Topics.ISLAND_ARRIVAL):
		await Utility.dialog_msg("Dialog.Rhode.Island_Arrival_1", true)
		await Utility.dialog_msg("Dialog.Rhode.Island_Arrival_2", true)
		await Utility.dialog_msg("Dialog.Rhode.Island_Arrival_3", true)
		await Utility.dialog_msg("Dialog.Rhode.Island_Arrival_4", true)
		await Utility.dialog_msg("Dialog.Rhode.Island_Arrival_5", true)
		Utility.dialog_msg("Dialog.Rhode.Island_Arrival_6")
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.MEREK)
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.FAIR_HAIRED_WOMAN)
	
	elif (topic == Enums.Topics.TOTEMS):
		Utility.dialog_msg("Dialog.Rhode.Totems")
	
	elif (topic == Enums.Topics.MEREK):
		await Utility.dialog_msg("Dialog.Rhode.Merek_1", true)
		await Utility.dialog_msg("Dialog.Rhode.Merek_2", true)
		Utility.dialog_msg("Dialog.Rhode.Merek_3")
	
	elif (topic == Enums.Topics.FAIR_HAIRED_WOMAN):
		Utility.dialog_msg("Dialog.Rhode.Fair_Haired_Woman")
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.MEREK)
	
	elif (topic == Enums.Topics.CURE):
		await Utility.dialog_msg("Dialog.Rhode.Cure_1", true)
		Utility.dialog_msg("Dialog.Rhode.Cure_2")
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.CURE_INGREDIENTS)
		
	elif (topic == Enums.Topics.CURE_INGREDIENTS):
		Utility.dialog_msg("Dialog.Rhode.Ingredients")
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.CURE_INGREDIENT_EGG)
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.CURE_INGREDIENT_PUFFBALL)
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.CURE_INGREDIENT_TARNROOT)
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.CURE_INGREDIENT_RAINBOW_SHELL)
		GameVars.set_var(Enums.Vars.LEARNED_INGREDIENTS, true)
	
	elif (topic == Enums.Topics.CURE_INGREDIENT_EGG):
		Utility.dialog_msg("Dialog.Rhode.Egg")
	
	elif (topic == Enums.Topics.CURE_INGREDIENT_PUFFBALL):
		await Utility.dialog_msg("Dialog.Rhode.Puffball_1", true)
		await Utility.dialog_msg("Dialog.Rhode.Puffball_2", true)
		Utility.dialog_msg("Dialog.Rhode.Puffball_3")
		Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.GLASS_SCISSORS)
	
	elif (topic == Enums.Topics.CURE_INGREDIENT_TARNROOT):
		Utility.dialog_msg("Dialog.Rhode.Tarnroot")
		
	elif (topic == Enums.Topics.CURE_INGREDIENT_RAINBOW_SHELL):
		Utility.dialog_msg("Dialog.Rhode.Rainbow_Shell")
	
	elif (topic == Enums.Topics.GLASS_SCISSORS):
		if (GameVars.get_var(Enums.Vars.LEARNED_INGREDIENTS)):
			Utility.dialog_msg("Dialog.Rhode.Scissors_Remember")
			GameVars.set_var(Enums.Vars.TAKE_SCISSORS_PERMISSION, true)
		else:
			Utility.dialog_msg("Dialog.Rhode.Scissors_Forgot")
	
	elif (topic == Enums.Topics.SWORD):
		Utility.dialog_msg("Dialog.Rhode.Sword")
		
	elif (topic == Enums.Topics.SHIELD):
		Utility.dialog_msg("Dialog.Rhode.Shield")
		
	elif (topic == Enums.Topics.CELLPHONE):
		Utility.dialog_msg("Dialog.Rhode.Cellphone")
		
	elif (topic == Enums.Topics.MAP):
		await Utility.dialog_msg("Dialog.Rhode.Map", true)
		Utility.dialog_msg("Dialog.Rhode.Map_2")
		Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.SILVER_BOX)
		
	elif (topic == Enums.Topics.SILVER_BOX):
		Utility.dialog_msg("Dialog.Rhode.Silver_Box")
		Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.MAP)
	
	elif (topic == Enums.Topics.RHODE):
		Utility.dialog_msg("Dialog.Rhode.Rhode")
		
	elif (topic == Enums.Topics.OPHELIA):
		Utility.dialog_msg("Dialog.Rhode.Ophelia")
		
	elif (topic == Enums.Topics.ARDEN
		or topic == Enums.Topics.EDRA
		or topic == Enums.Topics.MEREDITH
		or topic == Enums.Topics.STANLEY):
		Utility.dialog_msg("Dialog.Rhode.Unknown_Name")
	
	else:
		super.ask_about(topic)

extends BaseEvent

func investigate():
	await Utility.show_message(GameScript.get_entry("Forest.Swamp_Path.Rotten_Log_Look"))

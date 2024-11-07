extends BaseEvent

func investigate():
	Utility.show_message(GameScript.get_entry("Ruins.Lab.Science_Gear_Look"))

func take():
	Utility.show_message(GameScript.get_entry("Ruins.Lab.Science_Gear_Take"))

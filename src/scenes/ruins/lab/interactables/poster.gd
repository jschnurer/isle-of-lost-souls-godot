extends BaseEvent

func investigate():
	Utility.show_message(GameScript.get_entry("Ruins.Lab.Poster_Look"))
	GameVars.set_var(Enums.Vars.SAW_POSTER, true)

func take():
	Utility.show_message(GameScript.get_entry("Ruins.Lab.Poster_Take"))

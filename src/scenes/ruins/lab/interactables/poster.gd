extends BaseEvent

func investigate():
	Utility.msg("Ruins.Lab.Poster_Look")
	GameVars.set_var(Enums.Vars.SAW_POSTER, true)

func take():
	Utility.msg("Ruins.Lab.Poster_Take")

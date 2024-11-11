extends BaseEvent

func investigate():
	Utility.msg("Ruins.Hatch_Interior.Note_Look")

func take():
	Utility.msg("Ruins.Hatch_Interior.Note_Take")
	Inventory.add_item(Enums.ItemSlugs.HATCH_NOTE)
	GameVars.set_var(Enums.Vars.TOOK_HATCH_NOTE, true)

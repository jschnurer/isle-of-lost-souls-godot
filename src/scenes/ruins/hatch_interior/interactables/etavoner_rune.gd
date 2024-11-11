extends BaseEvent

func investigate():
	Utility.msg("Ruins.Hatch_Interior.Etavoner_Look")

func take():
	Utility.msg("Ruins.Hatch_Interior.Etavoner_Take")
	Inventory.add_item(Enums.ItemSlugs.ETAVONER_RUNE)
	GameVars.set_var(Enums.Vars.TOOK_ETAVONER, true)

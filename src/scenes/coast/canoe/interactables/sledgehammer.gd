extends BaseEvent

func investigate():
	Utility.msg("Coast.Canoe.Sledgehammer_Look")
	
func take():
	Utility.msg("Coast.Canoe.Sledgehammer_Take")
	Inventory.add_item(Enums.ItemSlugs.SLEDGE)
	GameVars.set_var(Enums.Vars.TOOK_SLEDGEHAMMER, true)

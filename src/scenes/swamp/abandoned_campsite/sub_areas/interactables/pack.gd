extends BaseEvent

func investigate():
	if (GameVars.get_var(Enums.Vars.TOOK_WATERLOGGED_NOTEBOOK)):
		Utility.msg("Swamp.Abandoned_Campsite_Tent.Pack_Look_No_Notebook")
	else:
		Utility.msg("Swamp.Abandoned_Campsite_Tent.Pack_Look")

func take():
	if (GameVars.get_var(Enums.Vars.TOOK_WATERLOGGED_NOTEBOOK)):
		Utility.msg("Swamp.Abandoned_Campsite_Tent.Pack_Take")
	else:
		Utility.msg("Swamp.Abandoned_Campsite_Tent.Notebook_Take")
		GameVars.set_var(Enums.Vars.TOOK_WATERLOGGED_NOTEBOOK, true)
		Inventory.add_item(Enums.ItemSlugs.OPHELIAS_JOURNAL1)

extends BaseEvent

func investigate():
	Utility.msg("Forest.Bend_Sack.Coin_Look")
	
func take():
	Inventory.add_item(Enums.ItemSlugs.COIN)
	GameVars.set_var(Enums.Vars.TOOK_COIN, true)
	await Utility.msg("Forest.Bend_Sack.Coin_Take")

extends BaseEvent

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_FLAG)):
		queue_free()
	else:
		super._ready()

func investigate():
	Utility.msg("Swamp.Abandoned_Campsite.Flagpole_Look")

func take():
	Utility.msg("Swamp.Abandoned_Campsite.Flag_Take")
	GameVars.set_var(Enums.Vars.TOOK_FLAG, true)
	Inventory.add_item(Enums.ItemSlugs.RED_FABRIC)
	queue_free()

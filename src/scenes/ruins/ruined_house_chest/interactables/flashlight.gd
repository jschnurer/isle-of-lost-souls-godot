extends BaseEvent

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_FLASHLIGHT)):
		queue_free()
	else:
		super._ready()

func investigate():
	Utility.msg("Ruins.House.Flashlight_Look")

func take():
	GameVars.set_var(Enums.Vars.TOOK_FLASHLIGHT, true)
	$Sprite2D.visible = false
	await Utility.msg("Ruins.House.Flashlight_Take")
	Inventory.add_item(Enums.ItemSlugs.FLASHLIGHT)
	queue_free()

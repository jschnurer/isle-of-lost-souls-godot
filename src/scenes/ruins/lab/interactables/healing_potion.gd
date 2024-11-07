extends BaseEvent

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_POTION)):
		queue_free()
	else:
		super._ready()

func investigate():
	Utility.show_message(GameScript.get_entry("Ruins.Lab.Potion_Look"))

func take():
	GameVars.set_var(Enums.Vars.TOOK_POTION, true)
	Inventory.add_item(Enums.ItemSlugs.POTION)
	$Sprite2D.visible = false
	await Utility.show_message(GameScript.get_entry("Ruins.Lab.Potion_Take"))
	queue_free()

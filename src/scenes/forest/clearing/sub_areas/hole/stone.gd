extends BaseEvent

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_STONE)):
		call_deferred("queue_free")
	else:
		super._ready()

func investigate():
	Utility.msg("Forest.Clearing.Hole_Stone_Look")

func take():
	Inventory.add_item(Enums.ItemSlugs.FISH_STONE)
	$Sprite.queue_free()
	await Utility.msg("Forest.Clearing.Hole_Stone_Take")
	GameVars.set_var(Enums.Vars.TOOK_STONE, true)
	call_deferred("queue_free")

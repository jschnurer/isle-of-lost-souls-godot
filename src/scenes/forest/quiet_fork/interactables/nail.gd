extends "res://src/events/game_event/base_event.gd"

@export var nail_missing_texture: Texture2D

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_NAIL)):
		queue_free()
	else:
		super._ready()

func investigate():
	Utility.msg("Forest.Quiet_Fork.Nail_Look")

func take():
	Inventory.add_item(Enums.ItemSlugs.NAIL)
	GameVars.set_var(Enums.Vars.TOOK_NAIL, true)
	$"../SceneBG".set_bg_texture(nail_missing_texture)
	$Sprite2D.queue_free()
	await Utility.msg("Forest.Quiet_Fork.Nail_Take")
	queue_free()

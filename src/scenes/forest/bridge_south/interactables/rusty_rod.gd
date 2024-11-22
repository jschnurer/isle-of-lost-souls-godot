extends "res://src/events/game_event/base_event.gd"

@export var death_sound: AudioStream

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_RIVER_ROD)):
		queue_free()
	else:
		super._ready()

func investigate():
	Utility.msg("Forest.Bridge_South.Rod_Look")

func take():
	if (!GameVars.get_var(Enums.Vars.DISTRACTED_FISH)):
		Utility.initiate_game_over(Enums.Scenes.GAME_OVER_FISH, 3, death_sound)
	else:
		$AnimatedSprite2D.queue_free()
		await Utility.msg("Forest.Bridge_South.Rod_Take_Successful")
		Inventory.add_item(Enums.ItemSlugs.RUINS_ROD)
		GameVars.set_var(Enums.Vars.TOOK_RIVER_ROD, true)
		queue_free()

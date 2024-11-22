extends "res://src/events/game_event/base_event.gd"

func _ready():
	if (GameVars.get_var(Enums.Vars.TOOK_NAIL)):
		$Sprite2D.region_rect = Rect2(43, 0, 43, 32)
	super._ready()

func investigate():
	if (GameVars.get_var(Enums.Vars.TOOK_NAIL)):
		await Utility.msg("Forest.Quiet_Fork.Signpost_Look_Without_Nail")
	else:
		await Utility.msg("Forest.Quiet_Fork.Signpost_Look_With_Nail")
		
	Utility.go_to_sub_area(Enums.Scenes.FOREST_QUIET_FORK_SIGNPOST)
	
func take():
	Utility.msg("Forest.Quiet_Fork.Signpost_Take")

func use_item(_item: Item):
	pass

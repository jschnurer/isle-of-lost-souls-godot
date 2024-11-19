@tool
extends BaseEvent

enum TotemVariants { TOTEM1, TOTEM2, TOTEM3 }

@export var totem_textures: Array[Texture2D] = []

var _variant: TotemVariants = TotemVariants.TOTEM1

@export var variant: TotemVariants:
	set(value):
		_variant = value
		$Sprite2D.texture = totem_textures[int(value)]
	get:
		return _variant

@export var flip_h: bool:
	set(value):
		$Sprite2D.flip_h = value
	get:
		return $Sprite2D.flip_h

func investigate():
	Utility.msg("Swamp.Hut_Exterior.Totem_Look")

func take():
	Utility.msg("Swamp.Hut_Exterior.Totem_Take")

func interact():
	Utility.msg("Swamp.Hut_Exterior.Totem_Interact")

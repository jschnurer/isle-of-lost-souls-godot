@tool
extends Sprite2D

enum SwampyGroundVariants { ThreeTufts, TwoTufts }
@export var textures: Array[Texture2D] = []

var _variant: SwampyGroundVariants = SwampyGroundVariants.ThreeTufts

@export var variant: SwampyGroundVariants:
	set(value):
		_variant = value
		texture = textures[int(value)]
	get:
		return _variant

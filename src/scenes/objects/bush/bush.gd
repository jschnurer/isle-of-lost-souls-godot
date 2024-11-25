@tool
extends Node2D

@export var bush_texture: Texture2D
@export var bramble_texture: Texture2D

var _type: Enums.BushTypes = Enums.BushTypes.BUSH
@export var type: Enums.BushTypes:
	set(value):
		_type = value
		update_sprite()
	get:
		return _type

func update_sprite():
	if (_type == Enums.BushTypes.BUSH):
		$Sprite2D.texture = bush_texture
	elif (_type == Enums.BushTypes.BRAMBLES):
		$Sprite2D.texture = bramble_texture

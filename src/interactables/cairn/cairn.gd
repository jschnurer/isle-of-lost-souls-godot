@tool
extends "res://src/events/game_event/base_event.gd"

enum SpriteVariant { NORMAL, SHORT }

var _variant: SpriteVariant = SpriteVariant.NORMAL

@export var variant: SpriteVariant :
	get:
		return _variant
	set(value):
		_variant = value
		variant_changed()

@export var sprites: Array[Texture2D]

@export var investigate_game_script_key: String = "Global_Cairn_Look"

func variant_changed():
	$Sprite.texture = sprites[_variant]
	
	$GameEvent/NormalCollisionShape.disabled = _variant != SpriteVariant.NORMAL
	$StaticBody2D/NormalCollisionShape.disabled = _variant != SpriteVariant.NORMAL
	
	$GameEvent/ShortCollisionShape.disabled = _variant != SpriteVariant.SHORT
	$StaticBody2D/ShortCollisionShape.disabled = _variant != SpriteVariant.SHORT

func investigate():
	SignalBus.show_message.emit(GameScript.get(investigate_game_script_key) as String, false)

func take():
	SignalBus.show_message.emit(GameScript.Global_Cairn_Take, false)

func interact():
	SignalBus.show_message.emit(GameScript.Global_Cairn_Interact, false)
	# TODO: Implement saving the game.

func use_item(_item: Item):
	SignalBus.show_message.emit(GameScript.Global_No_Effect, false)

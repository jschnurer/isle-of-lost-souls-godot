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

@export var investigate_game_script_key: String = "Global.Cairn_Look"

func variant_changed():
	$Sprite.texture = sprites[_variant]
	
	$GameEvent/NormalCollisionShape.disabled = _variant != SpriteVariant.NORMAL
	$StaticBody2D/NormalCollisionShape.disabled = _variant != SpriteVariant.NORMAL
	
	$GameEvent/ShortCollisionShape.disabled = _variant != SpriteVariant.SHORT
	$StaticBody2D/ShortCollisionShape.disabled = _variant != SpriteVariant.SHORT

func investigate():
	Utility.show_message(GameScript.get_entry(investigate_game_script_key))

func take():
	Utility.show_message(GameScript.get_entry("Global.Cairn_Take"))

func interact():
	await Utility.show_message(GameScript.get_entry("Global.Cairn_Interact"))
	
	var choices: Array[String] = [GameScript.get_entry("Global.Save_Progress"), GameScript.get_entry("Global.Cancel")]
	var choice = await Utility.show_choice(choices, 1)
	
	if (choice.index == 1):
		Utility.show_message(GameScript.get_entry("Global.Save_Canceled"))
		return
	
	SignalBus.save_game.emit()

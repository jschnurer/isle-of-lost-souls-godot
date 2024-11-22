@tool
extends BaseEvent

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
	if (_variant == SpriteVariant.NORMAL):
		$Sprite.offset = Vector2(0, -14)
	else:
		$Sprite.offset = Vector2(0, -7)
	
	$GameEvent/NormalCollisionShape.disabled = _variant != SpriteVariant.NORMAL
	$StaticBody2D/NormalCollisionShape.disabled = _variant != SpriteVariant.NORMAL
	
	$GameEvent/ShortCollisionShape.disabled = _variant != SpriteVariant.SHORT
	$StaticBody2D/ShortCollisionShape.disabled = _variant != SpriteVariant.SHORT

func investigate():
	Utility.msg(investigate_game_script_key)

func take():
	Utility.msg("Global.Cairn_Take")

func interact():
	var choices: Array[String] = [
		get_slot_choice_text(1),
		get_slot_choice_text(2),
		get_slot_choice_text(3),
		GameScript.get_entry("Global.Cancel")
	]
	var choice = await Utility.choice_msg("Global.Cairn_Interact", false, choices, 3)
	
	if (choice.index == 3):
		Utility.msg("Global.Save_Canceled")
	else:
		SignalBus.save_game.emit(choice.index + 1)

func get_slot_choice_text(slot: int) -> String:
	return GameScript.get_entry("Global.SaveToSlot" + str(slot)) + ": " + SaveManager.get_game_time_from_slot(slot)
	

class_name BaseEvent
extends Node2D

var is_base_event = true
@export var auto_connect_child_game_event = true

func _ready():
	if (auto_connect_child_game_event):
		$GameEvent.connect("on_activate", _on_activate)

func _on_activate(input_action: Enums.InputAction):
	activate(input_action)

func activate(input_action: Enums.InputAction):
	if (input_action == Enums.InputAction.INVESTIGATE):
		investigate()
	elif (input_action == Enums.InputAction.INTERACT):
		interact()
	elif (input_action == Enums.InputAction.TAKE):
		take()
	elif (input_action == Enums.InputAction.USE_ITEM):
		use_item()
	
func investigate():
	pass
	
func take():
	pass
	
func interact():
	pass
	
func use_item():
	pass

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
		# TODO: Implement item chooser. Then send chosen item to use_item(item) or just cancel the event.
		use_item(null)
	elif (input_action == Enums.InputAction.COLLIDE):
		collide()
	
func investigate():
	Utility.show_message(GameScript.Global_Uninteresting)
	
func take():
	Utility.show_message(GameScript.Global_Dont_Take)
	
func interact():
	Utility.show_message(GameScript.Global_No_Mechanism_To_Interact)
	
func use_item(_item: Item):
	Utility.show_message(GameScript.Global_No_Effect)

func collide():
	pass

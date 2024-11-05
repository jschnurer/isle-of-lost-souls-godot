class_name BaseEvent
extends Node2D

var is_base_event = true
@export var auto_connect_child_game_event = true

func _ready():
	if (auto_connect_child_game_event):
		$GameEvent.on_activate.connect(_on_activate)

func _on_activate(input_action: Enums.InputAction):
	if (input_action == Enums.InputAction.INVESTIGATE):
		investigate()
	elif (input_action == Enums.InputAction.INTERACT):
		interact()
	elif (input_action == Enums.InputAction.TAKE):
		take()
	elif (input_action == Enums.InputAction.USE_ITEM):
		SignalBus.open_inventory.emit()
		var item = await SignalBus.inventory_closed
		use_item(item as Item)
	elif (input_action == Enums.InputAction.COLLIDE):
		collide()
	
func investigate():
	Utility.show_message(GameScript.get_entry("Global.Uninteresting"))
	
func take():
	Utility.show_message(GameScript.get_entry("Global.Dont_Take"))
	
func interact():
	Utility.show_message(GameScript.get_entry("Global.No_Mechanism_To_Interact"))
	
func use_item(_item: Item):
	Utility.show_message(GameScript.get_entry("Global.No_Effect"))

func collide():
	pass

class_name BaseEvent
extends Node2D

var is_base_event = true
@export var auto_connect_child_game_event = true
@export var auto_destroy_flag: Enums.Vars = Enums.Vars.UNSPECIFIED

func _ready():
	if (auto_destroy_flag != Enums.Vars.UNSPECIFIED):
		if (GameVars.get_var(auto_destroy_flag)):
			queue_free()
			return
		else:
			SignalBus.on_game_var_set.connect(_on_game_var_set)
	
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
		SignalBus.open_inventory.emit(Enums.InventoryMode.ITEM_CHOOSER)
		var item = await SignalBus.inventory_closed
		use_item(item as Item)
	elif (input_action == Enums.InputAction.COLLIDE):
		collide()
	
func investigate():
	Utility.msg("Global.Uninteresting")
	
func take():
	Utility.msg("Global.Dont_Take")
	
func interact():
	Utility.msg("Global.No_Mechanism_To_Interact")
	
func use_item(_item: Item):
	Utility.msg("Global.No_Effect")

func collide():
	pass

func _on_game_var_set(var_name: Enums.Vars, _value):
	if (var_name == auto_destroy_flag):
		queue_free()

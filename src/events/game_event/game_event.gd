class_name GameEvent
extends Area2D

## Determines activation priority by player (higher index = higher priority).
## If -1, the game event will search upwards until it finds the nearest
## BaseEvent and use that node's index instead.
@export var parent_node_index: int = -1
@export var activation_mode: Enums.ActivationMode = Enums.ActivationMode.ACTIVATE
@export var use_action_chooser: bool = true
signal on_activate(input_action: Enums.InputAction)
var is_hovered: bool = false

func _ready():
	if (parent_node_index == -1):
		var parent_node = get_parent()
		while (parent_node != null):
			if (parent_node is BaseEvent):
				parent_node_index = parent_node.get_index()
				break
			else:
				parent_node = parent_node.get_parent()

func activate(input_action: Enums.InputAction):
	on_activate.emit(input_action)

func _on_area_entered(area: Area2D) -> void:
	if (activation_mode == Enums.ActivationMode.ACTIVATE and area.name != "FeetArea"):
		SignalBus.game_event_entered_range.emit(self)
	elif (activation_mode == Enums.ActivationMode.COLLIDE and area.name == "FeetArea"):
		activate(Enums.InputAction.COLLIDE)

func _on_area_exited(area: Area2D) -> void:
	if (activation_mode == Enums.ActivationMode.ACTIVATE and area.name != "FeetArea"):
		SignalBus.game_event_exited_range.emit(self)

class_name GameEvent
extends Area2D

@export var activation_mode: Enums.ActivationMode = Enums.ActivationMode.ACTIVATE
signal on_activate

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

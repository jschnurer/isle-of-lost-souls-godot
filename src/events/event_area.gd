extends Area2D

@export var event_type: Enums.EventType = Enums.EventType.DIALOG
@export var teleport_to_scene: Enums.Scenes
@export var teleport_to_location: Vector2
@export var dialog_key = ""
@export var activation_mode: Enums.ActivationMode = Enums.ActivationMode.ACTIVATE
var area_active = false

func  _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		activate()

func activate():
	if (event_type == Enums.EventType.DIALOG):
		SignalBus.emit_signal("display_dialog", dialog_key)
	elif (event_type == Enums.EventType.TELEPORT):
		SignalBus.emit_signal("transfer_player_to_scene", teleport_to_scene, teleport_to_location)

func _on_area_entered(area: Area2D) -> void:
	if (activation_mode == Enums.ActivationMode.ACTIVATE and area.name != "FeetArea"):
		area_active = true
	elif (activation_mode == Enums.ActivationMode.COLLIDE and area.name == "FeetArea"):
		area_active = true
		activate()

func _on_area_exited(area: Area2D) -> void:
	if (activation_mode == Enums.ActivationMode.ACTIVATE and area.name != "FeetArea"):
		area_active = false
	elif (activation_mode == Enums.ActivationMode.COLLIDE and area.name == "FeetArea"):
		area_active = false

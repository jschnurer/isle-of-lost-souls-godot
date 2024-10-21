extends Area2D

@export var activation_mode: Enums.ActivationMode = Enums.ActivationMode.ACTIVATE
var area_active = false
signal on_activate

func  _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		activate()

func activate():
	on_activate.emit()

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

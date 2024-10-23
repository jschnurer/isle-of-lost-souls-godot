@tool
extends CanvasLayer

var _input_method: Enums.InputMethod = Enums.InputMethod.PC

@export var input_method: Enums.InputMethod :
	set(value):
		_input_method = value
		update_icons()
	get:
		return _input_method
		
var use_item_location_controller = Vector2(0, -24)
var take_location_controller = Vector2(-24, 0)
var interact_location_controller = Vector2(24, 0)
var investigate_location_controller = Vector2(0, 24)

func show_hint():
	self.visible = true

func hide_hint():
	self.visible = false

func update_icons():
	$UseItem.input_method = _input_method
	$Take.input_method = _input_method
	$Interact.input_method = _input_method
	$Investigate.input_method = _input_method

	if (input_method == Enums.InputMethod.PC):
		pass
	else:
		$UseItem.position = use_item_location_controller
		$Take.position = take_location_controller
		$Interact.position = interact_location_controller
		$Investigate.position = investigate_location_controller

@tool
extends Sprite2D

var _input_method: Enums.InputMethod
var _action: Enums.InputAction

@export var xbox_sheet: Texture2D
@export var pc_sheet: Texture2D
@export var action: Enums.InputAction :
	set(value):
		_action = value
		update_icon()
	get:
		return _action
@export var input_method: Enums.InputMethod :
	set(value):
		_input_method = value
		update_icon()
	get:
		return _input_method

func update_icon():
	if (_input_method == Enums.InputMethod.PC):
		texture = pc_sheet
	elif (_input_method == Enums.InputMethod.XBOX):
		texture = xbox_sheet
	
	if (_action == Enums.InputAction.INVESTIGATE):
		region_rect = Rect2(Vector2(16, 64), Vector2(16, 16))
	elif (_action == Enums.InputAction.INTERACT):
		region_rect = Rect2(Vector2(32, 64), Vector2(16, 16))
	elif (_action == Enums.InputAction.TAKE):
		region_rect = Rect2(Vector2(48, 64), Vector2(16, 16))
	elif (_action == Enums.InputAction.USE_ITEM):
		region_rect = Rect2(Vector2(64, 64), Vector2(16, 16))

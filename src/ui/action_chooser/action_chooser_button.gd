extends Button

@export var is_cancel_button = false
@export var action: Enums.InputAction
var chooser

func _ready():
	chooser = get_parent().get_parent().get_parent()
	pressed.connect(_button_pressed)
	mouse_entered.connect(_on_mouse_entered)

func _button_pressed():
	if (is_cancel_button):
		chooser.cancel()
	else:
		chooser.choose_action(action)

func _on_mouse_entered():
	chooser.mouseover_button(self)

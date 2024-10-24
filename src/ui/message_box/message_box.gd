extends CanvasLayer

@onready var background = $Panel
@onready var text_label = $Panel/Text
@onready var ok_label = $Panel/OK

var appearance_time = 0
var time_before_can_close = .25

func _ready():
	background.visible = false
	SignalBus.connect("show_message", _on_show_message)

func _process(delta):
	if (background.visible and appearance_time < time_before_can_close):
		appearance_time += delta
		
	if (appearance_time >= time_before_can_close and background.visible):
		if (Input.is_action_just_pressed("ui_accept")
			or Input.is_action_just_pressed("investigate")
			or Input.is_action_just_pressed("use_item")
			or Input.is_action_just_pressed("interact")
			or Input.is_action_just_pressed("take")):
			finish()

func toggle(is_on: bool):
	if (not is_on):
		text_label.text = ""
		ok_label.text = ""
		
	background.visible = is_on
	get_tree().paused = is_on
	appearance_time = 0

func finish():
	toggle(false)
	SignalBus.message_closed.emit()

func _on_show_message(message: String, has_more: bool):
	text_label.text = message
	if has_more:
		ok_label.text = "..."
	else:
		ok_label.text = "x"
	toggle(true)

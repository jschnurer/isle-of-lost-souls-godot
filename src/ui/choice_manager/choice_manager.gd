extends CanvasLayer

@onready var container = $CenterContainer/VBoxContainer
var is_open = false
var delay_event_time = 0
var delay_before_can_choose = .1
var cancel_choice_index = 0

func _ready():
	SignalBus.show_choice.connect(_on_show_choice)
	hide()
	
func _process(delta: float) -> void:
	if (is_open and delay_event_time < delay_before_can_choose):
		delay_event_time += delta
		
func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_cancel")):
		var btn = container.get_child(cancel_choice_index) as Button
		var choice = Choice.new()
		choice.text = btn.text
		choice.index = cancel_choice_index
		_on_choose(choice)

func toggle(open: bool):
	delay_event_time = 0
	is_open = open
	clear_container()
	
	if (open):
		show()
		Utility.pause()
	else:
		hide()
		Utility.unpause()

func _on_show_choice(choices: Array[String], cancel_index: int):
	toggle(true)
	
	cancel_choice_index = cancel_index
	
	var i = 0
	for choice in choices:
		var btn = Button.new()
		btn.custom_minimum_size = Vector2(0, 40)
		btn.text = choice
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER & Control.SIZE_EXPAND
		btn.pressed.connect(_on_choice_made.bind(choice, i))
		container.add_child(btn)
		if (i == 0):
			btn.grab_focus()
		i += 1
	
func clear_container():
	var buttons = container.get_children()
	for button in buttons:
		button.queue_free()

func _on_choice_made(text: String, choice_index: int):
	var choice = Choice.new()
	choice.text = text
	choice.index = choice_index
	_on_choose(choice)

func _on_choose(choice: Choice):
	if (delay_event_time >= delay_before_can_choose):
		toggle(false)
		SignalBus.choice_chosen.emit(choice)

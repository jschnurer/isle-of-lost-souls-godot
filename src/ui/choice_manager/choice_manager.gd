extends CanvasLayer

@onready var center_container = $CenterContainer
@onready var container = $CenterContainer/VBoxContainer
var is_open = false
var delay_event_time = 0
var delay_before_can_choose = .1
var cancel_choice_index = 0
var waiting_for_message = false
var must_close_message = false

func _ready():
	SignalBus.show_choice.connect(_on_show_choice)
	hide()
	
func _process(delta: float) -> void:
	if (is_open and delay_event_time < delay_before_can_choose):
		delay_event_time += delta
		
func _input(event: InputEvent) -> void:
	if (is_open and event.is_action_pressed("ui_cancel")):
		var btn = container.get_child(cancel_choice_index) as Button
		var choice = Choice.new()
		choice.text = btn.text
		choice.index = cancel_choice_index
		_on_choose(choice)

func toggle(open: bool):
	delay_event_time = 0
	is_open = open
	
	if (open):
		show()
		Utility.pause()
	else:
		hide()
		Utility.unpause()

func _on_show_choice(choices: Array[String], cancel_index: int, choice_location: Enums.ChoiceLocation, has_simultaneous_message: bool):
	waiting_for_message = has_simultaneous_message
	
	if (not waiting_for_message):
		toggle(true)
	
	clear_container()
	
	if (choice_location == Enums.ChoiceLocation.CENTER):
		center_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	elif(choice_location == Enums.ChoiceLocation.BOTTOM):
		center_container.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	elif(choice_location == Enums.ChoiceLocation.TOP):
		center_container.set_anchors_preset(Control.PRESET_TOP_WIDE)
	
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
		clear_container()
		SignalBus.choice_chosen.emit(choice)
		if (must_close_message):
			MessageBox._on_choice_chosen()

func waiting_message_shown():
	waiting_for_message = false
	must_close_message = true
	toggle(true)
	if (container.get_child_count() > 0):
		container.get_child(0).grab_focus()

extends CanvasLayer

enum MessageBoxState { OPENING, TYPING, SHOWN, CLOSING, CLOSED }

@onready var panel = $Panel
@onready var text_label = $Panel/Text
@onready var ok_label = $Panel/OK

var appearance_time = 0
var state = MessageBoxState.CLOSED
var characters_per_second = 40
var typing_time_elapsed = 0
var stay_open = false

func _ready():
	panel.visible = false
	SignalBus.show_message.connect(_on_show_message)
	
func _on_show_message(message: String, has_more: bool):
	Utility.pause()
	text_label.text = Utility.parse_colors(message)
	text_label.visible_characters = 0
	stay_open = has_more
	
	if has_more:
		ok_label.text = "⯮"
	else:
		ok_label.text = "✓"
	
	typing_time_elapsed = 0
	appearance_time = 0
	panel.visible = true
	
	if (state == MessageBoxState.CLOSED):
		set_state(MessageBoxState.OPENING)
		$AnimationPlayer.play("opening")
	elif (state == MessageBoxState.SHOWN):
		set_state(MessageBoxState.TYPING)

func _process(delta):
	if (state == MessageBoxState.TYPING):
		process_typing(delta)
	elif (state == MessageBoxState.SHOWN):
		if (not ChoiceManager.visible):
			process_closable()

func process_typing(delta: float):
	typing_time_elapsed += delta
	text_label.visible_characters = typing_time_elapsed * characters_per_second
	
	if (text_label.visible_characters >= text_label.text.length()):
		set_state(MessageBoxState.SHOWN)
		
	if (Input.is_action_just_pressed("ui_accept")):
		text_label.visible_characters = text_label.text.length()
		set_state(MessageBoxState.SHOWN)

func process_closable():
	if (Input.is_action_just_pressed("ui_accept")):
		if (stay_open):
			finish_message()
		else:
			set_state(MessageBoxState.CLOSING)
			$AnimationPlayer.play("closing")

func _opening_anim_done():
	set_state(MessageBoxState.TYPING)
	
func _closing_anim_done():
	set_state(MessageBoxState.CLOSED)
	panel.visible = false
	finish_message()
	
func _typing_anim_done():
	set_state(MessageBoxState.SHOWN)

func finish_message():
	text_label.text = ""
	typing_time_elapsed = 0
	appearance_time = 0
	Utility.unpause()
	SignalBus.message_closed.emit()

func set_state(new_state: MessageBoxState):
	state = new_state
	
	if (new_state == MessageBoxState.SHOWN):
		if (ChoiceManager.waiting_for_message):
			# Reveal the waiting choice.
			ChoiceManager.waiting_message_shown()

func _on_choice_chosen():
	Utility.pause()
	if (stay_open):
		finish_message()
	else:
		set_state(MessageBoxState.CLOSING)
		$AnimationPlayer.play("closing")

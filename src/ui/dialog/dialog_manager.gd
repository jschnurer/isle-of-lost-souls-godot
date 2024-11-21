extends CanvasLayer

enum FocusedArea {MESSAGE,TOPICS}

@onready var message_text = $MessageBox/Text
@onready var ok_label = $MessageBox/OK
@onready var topics_container = $Topics/MarginContainer/GridContainer
@onready var portrait = $Portrait
@export var active_panel_stylebox: StyleBoxFlat
var is_open = false
var loaded_dialog: BaseDialog = null
var focused_area = FocusedArea.TOPICS
var current_msg_has_more = false
var available_topics: Array[DialogTopic] = []
var selected_topic_slug: Enums.Topics = Enums.Topics.WHO_ARE_YOU
var delay_event_time = 0
var delay_before_can_choose_topic = .1

func _ready():
	SignalBus.open_dialog_manager.connect(_on_open_dialog_manager)
	SignalBus.close_dialog_manager.connect(_on_close_dialog_manager)
	SignalBus.show_dialog_message.connect(_on_show_dialog_message)
	SignalBus.on_topic_learned.connect(_on_topic_learned)
	self.visible = false

func _process(delta: float):
	if (is_open and delay_event_time < delay_before_can_choose_topic):
		delay_event_time += delta

func _input(event: InputEvent) -> void:
	if (focused_area == FocusedArea.MESSAGE
	and event.is_action_pressed("ui_accept")):
		if (current_msg_has_more):
			SignalBus.dialog_message_closed.emit()
		else:
			message_text.text = ""
			set_focus(FocusedArea.TOPICS)

func _on_open_dialog_manager(dialog: BaseDialog):
	loaded_dialog = dialog
	load_portrait()
	load_topics()
	message_text.text = ""
	Utility.pause()
	self.visible = true
	is_open = true
	set_focus(FocusedArea.TOPICS)
	loaded_dialog.on_greet()
	delay_event_time = 0
	portrait.flip_h = dialog.flip_portrait_h
	
func _on_close_dialog_manager():
	loaded_dialog = null
	$Portrait.texture = null
	clear_topics()
	message_text.text = ""
	self.visible = false
	is_open = false
	Utility.unpause()
	
func set_focus(new_focus: FocusedArea):
	focused_area = new_focus
	if (focused_area == FocusedArea.TOPICS):
		delay_event_time = 0
		toggle_topics(true)
		for child in topics_container.get_children():
			if (child.get_meta("topic_slug") as Enums.Topics == selected_topic_slug):
				(child as Button).grab_focus()
		$Topics.add_theme_stylebox_override("panel", active_panel_stylebox)
		$MessageBox.remove_theme_stylebox_override("panel")
	else:
		toggle_topics(false)
		for child in topics_container.get_children():
			(child as Button).release_focus()
		$Topics.remove_theme_stylebox_override("panel")
		$MessageBox.add_theme_stylebox_override("panel", active_panel_stylebox)

func _on_show_dialog_message(message: String, has_more: bool):
	message_text.text = message
	current_msg_has_more = has_more
	if (has_more):
		set_focus(FocusedArea.MESSAGE)
	else:
		set_focus(FocusedArea.TOPICS)
	
	if has_more:
		ok_label.text = "⯮"
	else:
		ok_label.text = "✓"

func clear_topics():
	for child in topics_container.get_children():
		child.queue_free()

func toggle_topics(is_enabled: bool):
	for child in topics_container.get_children():
		(child as Button).disabled = !is_enabled

func load_portrait():
	if (loaded_dialog.portrait_texture == null):
		$Portrait.visible = false
	else:
		$Portrait.visible = true
		$Portrait.texture = loaded_dialog.portrait_texture

func load_topics():
	available_topics = DialogTopics.get_available_topics(loaded_dialog.topic_group)
	clear_topics()
	for dialog_topic in available_topics:
		var btn = Button.new()
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.text = dialog_topic.text
		btn.set_meta("topic_slug", dialog_topic.slug)
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		btn.pressed.connect(_on_topic_chosen.bind(dialog_topic.slug))
		btn.focus_entered.connect(_on_topic_focused.bind(dialog_topic.slug))
		if (dialog_topic.slug == Enums.Topics.GOODBYE):
			btn.add_theme_color_override("font_color", Color.DARK_RED)
		topics_container.add_child(btn)
		if (selected_topic_slug == dialog_topic.slug):
			btn.grab_focus()

func _on_topic_learned(topic_group: Enums.TopicGroups, _topic: Enums.Topics):
	if (is_open
	and loaded_dialog.topic_group == topic_group):
		load_topics()
		set_focus(FocusedArea.TOPICS)

func _on_topic_chosen(topic: Enums.Topics):
	if (delay_event_time < delay_before_can_choose_topic):
		return

	loaded_dialog.ask_about(topic)

func _on_topic_focused(topic: Enums.Topics):
	selected_topic_slug = topic

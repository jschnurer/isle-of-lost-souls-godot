extends CanvasLayer

enum FocusedArea {MESSAGE,TOPICS}

@onready var message_text = $MessageBox/Text
@onready var ok_label = $MessageBox/OK
@onready var topic_list = $Topics/ItemList

@export var active_panel_stylebox: StyleBoxFlat

var is_open = false
var loaded_dialog: BaseDialog = null
var focused_area = FocusedArea.TOPICS
var current_msg_has_more = false
var available_topics: Array[DialogTopic] = []

func _ready():
	SignalBus.open_dialog_manager.connect(_on_open_dialog_manager)
	SignalBus.close_dialog_manager.connect(_on_close_dialog_manager)
	SignalBus.show_dialog_message.connect(_on_show_dialog_message)
	SignalBus.on_topic_learned.connect(_on_topic_learned)
	self.visible = false

func _input(event: InputEvent) -> void:
	if (focused_area == FocusedArea.MESSAGE
	and event.is_action_pressed("ui_accept")):
		if (current_msg_has_more):
			SignalBus.dialog_message_closed.emit()
		else:
			message_text.text = ""
			set_focus(FocusedArea.TOPICS)
	elif (focused_area == FocusedArea.TOPICS
	and event.is_action_pressed("ui_accept")):
		var chosen_topics = topic_list.get_selected_items()
		if (chosen_topics.size() > 0):
			var topic_text = topic_list.get_item_text(chosen_topics[0])
			for dialog_topic in available_topics:
				if (dialog_topic.text == topic_text):
					loaded_dialog.ask_about(dialog_topic.slug)

func _on_open_dialog_manager(dialog: BaseDialog):
	loaded_dialog = dialog
	load_topics()
	message_text.text = ""
	get_tree().paused = true
	self.visible = true
	is_open = true
	topic_list.grab_focus()
	set_focus(FocusedArea.TOPICS)
	loaded_dialog.on_greet()
	
func _on_close_dialog_manager():
	loaded_dialog = null
	topic_list.clear()
	message_text.text = ""
	self.visible = false
	is_open = false
	get_tree().paused = false
	
func set_focus(new_focus: FocusedArea):
	focused_area = new_focus
	if (focused_area == FocusedArea.TOPICS):
		for ix in topic_list.item_count:
			topic_list.set_item_disabled(ix, false)
		topic_list.grab_focus()
		topic_list.select(0, true)
		$Topics.add_theme_stylebox_override("panel", active_panel_stylebox)
		$MessageBox.remove_theme_stylebox_override("panel")
	else:
		topic_list.release_focus()
		for ix in topic_list.item_count:
			topic_list.set_item_disabled(ix, true)
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

func load_topics():
	available_topics = DialogTopics.get_available_topics(loaded_dialog.topic_group)
	topic_list.clear()
	for dialog_topic in available_topics:
		topic_list.add_item(dialog_topic.text)

func _on_topic_learned(topic_group: Enums.TopicGroups, _topic: Enums.Topics):
	if (is_open
	and loaded_dialog.topic_group == topic_group):
		var chosen_topics = topic_list.get_selected_items()
		var sel_topic_text = ""
		if (chosen_topics.size() > 0):
			sel_topic_text = topic_list.get_item_text(chosen_topics[0])
		load_topics()
		set_focus(FocusedArea.TOPICS)
		
		if (sel_topic_text != ""):
			# Reselect the item the player had selected previously.
			for ix in topic_list.item_count:
				if (topic_list.get_item_text(ix) == sel_topic_text):
					topic_list.select(ix, true)
					break

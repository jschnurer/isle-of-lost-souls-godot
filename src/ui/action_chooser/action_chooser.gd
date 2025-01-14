extends CanvasLayer

@onready var vbox = $VBox
@onready var btn_interact = $VBox/TopRow/Interact
@onready var btn_use_item = $VBox/CenterRow/UseItem
@onready var btn_investigate = $VBox/BottomRow/Investigate
@onready var btn_take = $VBox/CenterRow/Take
@onready var btn_cancel = $VBox/CenterRow/Cancel

var btn_focused
var appearance_time = 0
var time_before_can_close = .25
var was_dir_pressed = false

func _ready():
	vbox.visible = false
	set_button_texts()
	SignalBus.show_action_chooser.connect(_on_show_action_chooser)

func _on_show_action_chooser():
	toggle(true)

func toggle(is_on: bool):
	if (not is_on):
		pass
	
	vbox.visible = is_on
	if (is_on):
		Utility.pause()
	else:
		Utility.unpause()
	appearance_time = 0
	
func _process(delta):
	if (!vbox.visible):
		return
		
	if (appearance_time < time_before_can_close):
		appearance_time += delta
	
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	if (direction_x != 0 or direction_y != 0):
		was_dir_pressed = true
	
	if (direction_x == -1):
		focus_button(btn_use_item)
	elif (direction_x == 1):
		focus_button(btn_take)
	elif (direction_y == 1):
		focus_button(btn_investigate)
	elif (direction_y == -1):
		focus_button(btn_interact)
	elif (was_dir_pressed):
		focus_button(btn_cancel)
		
	if (appearance_time >= time_before_can_close
		and btn_focused
		and Input.is_action_pressed("ui_accept")):
		var action_chosen = null
		
		if (btn_focused == btn_investigate):
			choose_action(Enums.InputAction.INVESTIGATE)
		elif (btn_focused == btn_interact):
			choose_action(Enums.InputAction.INTERACT)
		elif (btn_focused == btn_take):
			choose_action(Enums.InputAction.TAKE)
		elif (btn_focused == btn_use_item):
			choose_action(Enums.InputAction.USE_ITEM)

func focus_button(btn_node: Button):
	btn_node.grab_focus()
	btn_focused = btn_node

func mouseover_button(btn_node: Button):
	was_dir_pressed = false
	focus_button(btn_node)

func choose_action(action: Enums.InputAction):
	toggle(false)
	SignalBus.action_chooser_closed.emit(action)

func cancel():
	toggle(false)

func set_button_texts():
	btn_cancel.text = GameScript.get_entry("Global.Cancel")
	btn_investigate.text = GameScript.get_entry("Global.Investigate")
	btn_interact.text = GameScript.get_entry("Global.Interact")
	btn_take.text = GameScript.get_entry("Global.Take")
	btn_use_item.text = GameScript.get_entry("Global.Use_Item")

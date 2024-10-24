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

func _ready():
	vbox.visible = false
	SignalBus.show_action_chooser.connect(_on_show_action_chooser)

func _on_show_action_chooser():
	toggle(true)

func toggle(is_on: bool):
	if (not is_on):
		pass
	
	vbox.visible = is_on
	get_tree().paused = is_on
	appearance_time = 0
	
func _process(delta):
	if (!vbox.visible):
		return
		
	if (appearance_time < time_before_can_close):
		appearance_time += delta
	
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	if (direction_x == -1):
		focus_button(btn_use_item)
	elif (direction_x == 1):
		focus_button(btn_take)
	elif (direction_y == 1):
		focus_button(btn_investigate)
	elif (direction_y == -1):
		focus_button(btn_interact)
	else:
		focus_button(btn_cancel)
		
	if (appearance_time >= time_before_can_close
		and btn_focused
		and Input.is_action_pressed("ui_accept")):
		toggle(false)
		var chosen_text = btn_focused.text
		var action_chosen = null

		if (chosen_text == "Investigate"):
			action_chosen = Enums.InputAction.INVESTIGATE
		elif (chosen_text == "Interact"):
			action_chosen = Enums.InputAction.INTERACT
		elif (chosen_text == "Take"):
			action_chosen = Enums.InputAction.TAKE
		elif (chosen_text == "Use Item"):
			action_chosen = Enums.InputAction.USE_ITEM
		
		SignalBus.action_chooser_closed.emit(action_chosen)

func focus_button(btn_node: Button):
	btn_node.grab_focus()
	btn_focused = btn_node

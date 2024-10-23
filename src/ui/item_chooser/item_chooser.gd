extends Node2D

@onready var item_list = $ItemList
var appearance_time = 0
var time_before_can_close = .25

func _ready():
	item_list.visible = false
	SignalBus.show_item_chooser.connect(_on_show_item_chooser)

func _on_show_item_chooser():
	var inv_items = Inventory.get_items()
	
	for item in inv_items:
		$ItemList.add_item(item.name)
	
	toggle(true)

func toggle(is_on: bool):
	if (not is_on):
		pass
	
	item_list.visible = is_on
	get_tree().paused = is_on
	appearance_time = 0
	
func _process(delta):
	if (item_list.visible and appearance_time < time_before_can_close):
		appearance_time += delta
		
	if (appearance_time >= time_before_can_close and item_list.visible):
		if (Input.is_action_just_pressed("ui_accept")
			or Input.is_action_just_pressed("investigate")
			or Input.is_action_just_pressed("use_item")
			or Input.is_action_just_pressed("interact")
			or Input.is_action_just_pressed("take")):
			pass

extends CanvasLayer

var is_open = false
var delay_event_time = 0
var delay_before_can_choose = .1
@onready var grid_container = $VBoxContainer/Items/MarginContainer/GridContainer
@onready var item_description_lbl = $VBoxContainer/Description/MarginContainer/Label

func _ready():
	hide()
	SignalBus.open_inventory.connect(_on_open_inventory)

func _process(delta: float) -> void:
	if (is_open and delay_event_time < delay_before_can_choose):
		delay_event_time += delta
		
func _input(event: InputEvent):
	if (!is_open or delay_event_time < delay_before_can_choose):
		return
	
	if (event.is_action_pressed("ui_cancel")):
		toggle(false)

func _on_open_inventory():
	toggle(true)

func toggle(is_active):
	delay_event_time = 0
	is_open = is_active
	
	for child in grid_container.get_children():
		child.queue_free()
	
	if (is_open):
		populate_grid()
		show()
		Utility.pause()
	else:
		hide()
		Utility.unpause()

func populate_grid():
	var items = Inventory.get_items()
	
	for item in items:
		var btn = Button.new()
		btn.text = item.name
		if (item.quantity > 1):
			btn.text += " (" + item.quantity + ")"
		btn.set_meta("item_slug", item.slug)
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		btn.pressed.connect(_on_item_chosen.bind(item))
		btn.focus_entered.connect(_on_item_focused.bind(item))
		grid_container.add_child(btn)
	
	if (grid_container.get_child_count() > 0):
		(grid_container.get_child(0) as Button).grab_focus()

func _on_item_chosen(item: Item):
	SignalBus.inventory_closed.emit(item)
	toggle(false)

func _on_item_focused(item: Item):
	item_description_lbl.text = item.description

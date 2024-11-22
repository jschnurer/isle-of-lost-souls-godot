extends "res://src/events/game_event/base_event.gd"

@onready var rod_sprite_up = $RodUp
@onready var rod_sprite_down = $RodDown

func _ready():
	super._ready()
	update_sprite()
	
func update_sprite():
	if (not GameVars.get_var(Enums.Vars.ROD_IN_DEVICE)):
		rod_sprite_up.visible = false
		rod_sprite_down.visible = false
		return
		
	var is_door_open = GameVars.get_var(Enums.Vars.RUIN_HALL_DOOR_OPEN)

	rod_sprite_up.visible = not is_door_open
	rod_sprite_down.visible = is_door_open == true

func investigate():
	var message = GameScript.get_entry("Ruins.Hall.Device_Look") + " "
	
	if (GameVars.get_var(Enums.Vars.RUIN_HALL_DOOR_OPEN)):
		message += GameScript.get_entry("Ruins.Hall.Device_Pointed_Up")
	else:
		message += GameScript.get_entry("Ruins.Hall.Device_Pointed_Down")
	
	if (GameVars.get_var(Enums.Vars.ROD_IN_DEVICE) != true):
		message += "\n" + GameScript.get_entry("Ruins.Hall.Device_Opening_Look")
	else:
		message += "\n" + GameScript.get_entry("Ruins.Hall.Device_Has_Rod")
	
	Utility.show_message(message);

func interact():
	if (GameVars.get_var(Enums.Vars.ROD_IN_DEVICE) != true):
		Utility.msg("Ruins.Hall.Device_Interact_No_Rod")
	else:
		if (GameVars.get_var(Enums.Vars.RUIN_HALL_DOOR_OPEN)):
			Utility.msg("Ruins.Hall.Device_Door_Closes")
			GameVars.set_var(Enums.Vars.RUIN_HALL_DOOR_OPEN, false)
		else:
			Utility.msg("Ruins.Hall.Device_Door_Opens")
			GameVars.set_var(Enums.Vars.RUIN_HALL_DOOR_OPEN, true)
		update_sprite()

func take():
	if (GameVars.get_var(Enums.Vars.ROD_IN_DEVICE) != true):
		super.take()
	else:
		Utility.msg("Ruins.Hall.Device_Take_Rod")
		Inventory.add_item(Enums.ItemSlugs.RUINS_ROD)
		GameVars.set_var(Enums.Vars.ROD_IN_DEVICE, false)
		update_sprite()
	
func use_item(item: Item):
	if (item.slug == Enums.ItemSlugs.RUINS_ROD):
		Utility.msg("Ruins.Hall.Device_Use_Rod")
		Inventory.remove_item(Enums.ItemSlugs.RUINS_ROD)
		GameVars.set_var(Enums.Vars.ROD_IN_DEVICE, true)
		update_sprite()
	else:
		super.use_item(item)

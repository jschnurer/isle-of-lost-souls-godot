extends "res://src/events/game_event/base_event.gd"

@onready var rod_sprite = $RodSprite

func _ready():
	super._ready()
	update_sprite()
	
func update_sprite():
	rod_sprite.visible = GameVars.get_var(Enums.Vars.ROD_IN_TEMPLE_DEVICE) == true
	if (GameVars.get_var(Enums.Vars.MOVED_TEMPLE_ALTAR) != true):
		rod_sprite.rotation_degrees = -140
	else:
		rod_sprite.rotation_degrees = 0

func investigate():
	var message = GameScript.get_entry("Ruins.Hall.Device_Look") + " "
	
	if (GameVars.get_var(Enums.Vars.MOVED_TEMPLE_ALTAR)):
		message += GameScript.get_entry("Ruins.Hall.Device_Pointed_Up")
	else:
		message += GameScript.get_entry("Ruins.Hall.Device_Pointed_Down")
	
	if (GameVars.get_var(Enums.Vars.ROD_IN_TEMPLE_DEVICE) != true):
		message += "\n" + GameScript.get_entry("Ruins.Hall.Device_Opening_Look")
	else:
		message += "\n" + GameScript.get_entry("Ruins.Hall.Device_Has_Rod")
	
	Utility.show_message(message);

func interact():
	if (GameVars.get_var(Enums.Vars.ROD_IN_TEMPLE_DEVICE) != true):
		Utility.show_message(GameScript.get_entry("Ruins.Hall.Device_Interact_No_Rod"))
	else:
		if (GameVars.get_var(Enums.Vars.MOVED_TEMPLE_ALTAR)):
			Utility.show_message(GameScript.get_entry("Ruins.Temple_North.Device_Altar_Closes"))
			GameVars.set_var(Enums.Vars.MOVED_TEMPLE_ALTAR, false)
		else:
			Utility.show_message(GameScript.get_entry("Ruins.Temple_North.Device_Altar_Opens"))
			GameVars.set_var(Enums.Vars.MOVED_TEMPLE_ALTAR, true)
		update_sprite()

func take():
	if (GameVars.get_var(Enums.Vars.ROD_IN_TEMPLE_DEVICE) != true):
		super.take()
	else:
		Utility.show_message(GameScript.get_entry("Ruins.Hall.Device_Take_Rod"))
		Inventory.add_item(Enums.ItemSlugs.RUINS_ROD)
		GameVars.set_var(Enums.Vars.ROD_IN_TEMPLE_DEVICE, false)
		update_sprite()
	
func use_item(item: Item):
	if (item.slug == Enums.ItemSlugs.RUINS_ROD):
		Utility.show_message(GameScript.get_entry("Ruins.Hall.Device_Use_Rod"))
		Inventory.remove_item(Enums.ItemSlugs.RUINS_ROD)
		GameVars.set_var(Enums.Vars.ROD_IN_TEMPLE_DEVICE, true)
		update_sprite()
	else:
		super.use_item(item)

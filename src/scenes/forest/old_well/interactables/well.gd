extends BaseEvent

@export var pail_sprite: Texture2D
@export var rope_sprite: Texture2D
@onready var sprite: Sprite2D = $PailRopeSprite

func _ready():
	super._ready()
	update_pail_sprite()

func investigate():
	if (GameVars.get_var(Enums.Vars.WELL_PAIL_DOWN)):
		Utility.msg("Forest.Old_Well.Well_Look_Pail_Down")
	else:
		var item_in_pail = GameVars.get_var(Enums.Vars.ITEM_IN_PAIL)
		
		await Utility.msg("Forest.Old_Well.Well_Look_Pail_Up", true)
		
		if (item_in_pail):
			if (item_in_pail == Enums.ItemSlugs.ETAVONER_RUNE and GameVars.get_var(Enums.Vars.DROPPED_ETAVONER_IN_WELL)):
				Utility.msg("Forest.Old_Well.Well_Look_Pail_Etavoner")
			else:
				var msg = GameScript.get_entry("Forest.Old_Well.Well_Look_Pail_Item")
				var item_name = ItemDb.get_item(item_in_pail).name
				msg = msg.replace("#ITEMNAME#", item_name)
				Utility.show_message(msg)
		else:
			Utility.msg("Forest.Old_Well.Well_Look_Pail_Empty")

func take():
	if (GameVars.get_var(Enums.Vars.WELL_PAIL_DOWN)):
		Utility.msg("Forest.Old_Well.Well_Take_Pail_Down")
		return
	
	var item_in_pail = GameVars.get_var(Enums.Vars.ITEM_IN_PAIL)
	if (item_in_pail == Enums.ItemSlugs.ETAVONER_RUNE and GameVars.get_var(Enums.Vars.DROPPED_ETAVONER_IN_WELL)):
		GameVars.set_var(Enums.Vars.ITEM_IN_PAIL, null)
		await Utility.msg("Forest.Old_Well.Well_Take_Charged_Etavoner_1", true)
		Utility.msg("Forest.Old_Well.Well_Take_Charged_Etavoner_2")
	elif (item_in_pail):
		Inventory.add_item(item_in_pail)
		var item = ItemDb.get_item(item_in_pail)
		GameVars.set_var(Enums.Vars.ITEM_IN_PAIL, null)
		var msg = GameScript.get_entry("Forest.Old_Well.Well_Take_Pail_Item")
		msg = msg.replace("#ITEMNAME#", item.name)
		Utility.show_message(msg)
	else:
		Utility.msg("Forest.Old_Well.Well_Take_Empty")

func interact():
	if (GameVars.get_var(Enums.Vars.WELL_PAIL_DOWN)):
		Utility.msg("Forest.Old_Well.Well_Raise_Pail")
		GameVars.set_var(Enums.Vars.WELL_PAIL_DOWN, false)
	else:
		Utility.msg("Forest.Old_Well.Well_Drop_Pail")
		GameVars.set_var(Enums.Vars.WELL_PAIL_DOWN, true)
		
		if (GameVars.get_var(Enums.Vars.ITEM_IN_PAIL) == Enums.ItemSlugs.ETAVONER_RUNE):
			GameVars.set_var(Enums.Vars.DROPPED_ETAVONER_IN_WELL, true)
	
	update_pail_sprite()

func use_item(item: Item):
	if (GameVars.get_var(Enums.Vars.WELL_PAIL_DOWN)):
		Utility.msg("Forest.Old_Well.Well_Use_Item_Pail_Down")
		return
	
	if (GameVars.get_var(Enums.Vars.ITEM_IN_PAIL)):
		Utility.msg("Forest.Old_Well.Well_Use_Item_Pail_Full")
		return
	
	var put_message = GameScript.get_entry("Forest.Old_Well.Well_Use_Item_Put_Into_Pail")
	put_message = put_message.replace("#ITEMNAME#", item.name)
	GameVars.set_var(Enums.Vars.ITEM_IN_PAIL, item.slug)
	Inventory.remove_item(item.slug)
	Utility.show_message(put_message)

func update_pail_sprite():
	if (GameVars.get_var(Enums.Vars.WELL_PAIL_DOWN)):
		sprite.texture = rope_sprite
	else:
		sprite.texture = pail_sprite

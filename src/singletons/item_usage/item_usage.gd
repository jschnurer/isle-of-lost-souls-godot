extends Node2D

var item_slug_strings = Enums.ItemSlugs.keys()

func _ready():
	SignalBus.global_use_item.connect(_on_global_use_item)

func _on_global_use_item(item: Item):
	var item_node = get_node_or_null(item_slug_strings[item.slug])
	
	if (not item_node):
		Utility.msg("Global.Not_Usable_Alone")
	else:
		(item_node as BaseItemUsage).use_item()

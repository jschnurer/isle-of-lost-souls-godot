extends Node

var item_db = {}

func _ready():
	initialize_db()

func initialize_db():
	var file = "res://src/text/items.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var items_array = JSON.parse_string(json_as_text)
	
	for json_item in items_array:
		var new_item = Item.new()
		new_item.slug = Enums.ItemSlugs.get(json_item.slug)
		new_item.name = json_item.name
		new_item.description = json_item.description
		item_db[new_item.slug] = new_item

func get_item(slug: Enums.ItemSlugs):
	return item_db[slug]

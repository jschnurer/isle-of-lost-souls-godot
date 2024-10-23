extends Node

var slug_strings = Enums.ItemSlugs.keys()
var items: Array[Item] = []

func has_item(slug: Enums.ItemSlugs):
	for item in items:
		if (item.slug == slug):
			return true
	return false

func get_item_index(slug: Enums.ItemSlugs):
	for index in items.size():
		if (items[index].slug == slug):
			return index
	return -1

func add_item(slug: Enums.ItemSlugs, quantity: int = 1):
	var existing_index = get_item_index(slug)
	if (existing_index > -1):
		items[existing_index].quantity += 1
	else:
		items.append(ItemDb.get_item(slug))

func remove_item(slug: Enums.ItemSlugs, quantity: int = 1):
	var existing_index = get_item_index(slug)
	if (existing_index == -1):
		return
	
	var item = items[existing_index]
	
	if (item.quantity <= quantity):
		items.remove_at(existing_index)
	else:
		item.quantity -= quantity

func get_items():
	return items

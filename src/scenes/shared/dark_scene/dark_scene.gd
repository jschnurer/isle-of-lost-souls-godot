extends Node2D

@export var scene_bg: SceneBG
@export var dark_scene_bg: Texture2D
@export var light_scene_bg: Texture2D
@onready var dark_death = $DarkDeath

func _ready():
	handle_darkness()
	
func handle_darkness():
	if (!Inventory.has_item(Enums.ItemSlugs.FLASHLIGHT)):
		# Delete all child nodes except DarkDeath since those children can't be seen.
		var all_children = get_children()
		for child in all_children:
			if child != dark_death:
				child.queue_free()
		
		var img_arr: Array[Texture2D] = [dark_scene_bg]
		scene_bg.bg_images = img_arr
		
		await Utility.show_message("This place is so dark that you can't even see your hand in front of your face. Strange and terrible things make their homes in the dark. If you value your life, you should IMMEDIATELY head back the way you came and return with a light source.", true)
		Utility.show_message("It is pitch black. You are likely to be eaten by a grue.", false)
	else:
		var img_arr: Array[Texture2D] = [light_scene_bg]
		scene_bg.bg_images = img_arr
		
		queue_free()

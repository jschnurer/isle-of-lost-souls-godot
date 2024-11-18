extends Node

func _ready():
	SignalBus.save_game.connect(_on_save_game)
	SignalBus.load_game.connect(_on_load_game)

func _on_save_game(slot: int):
	var save_file = FileAccess.open("user://savegame" + str(slot) + ".save", FileAccess.WRITE)
	var player: Player = get_tree().get_first_node_in_group("Player")
	var scene_bg: SceneBG = get_tree().get_first_node_in_group("GameScene")
	
	# Save the player position, facing direction, scene, vars, and game time.
	var save_dict = {
		"player_pos": str(player.position.x) + "," + str(player.position.y),
		"facing": player.facing_dir,
		"scene": scene_bg.scene,
		"inventory": [],
		"vars": GameVars.get_all(),
		"game_time": GameTimer.get_time_elapsed(),
	}
	
	# Save the inventory data.
	var inv_items: Array[Item] = Inventory.get_items()
	for item in inv_items:
		var item_dict = {
			"slug": item.slug,
			"qty": item.quantity,
		}
		save_dict.inventory.append(item_dict)
	
	# Serialize and save
	var json_string = JSON.stringify(save_dict)
	save_file.store_line(json_string)
	
	# Also mark this slot as the most recently saved one.
	save_most_recent_slot_meta(slot)
	
	# Show the save complete message.
	Utility.show_message(GameScript.get_entry("Global.Save_Complete"))

func _on_load_game(slot: int):
	var file_name = "user://savegame" + str(slot) + ".save"
	if (!FileAccess.file_exists(file_name)):
		return
	
	# Load the save file.
	var save_game_text = FileAccess.get_file_as_string(file_name)
	var save_dict = JSON.parse_string(save_game_text)
	
	# TODO: Ensure proper json.
	
	# Find the player and set their facing direction
	var player: Player = get_tree().get_first_node_in_group("Player")
	player.facing_dir = int(save_dict.facing) as Enums.Direction
	
	# Replace all GameVars.
	GameVars.set_all(save_dict.vars)
	
	# Clear and load the inventory.
	Inventory.clear()
	for item in save_dict.inventory:
		Inventory.add_item(int(item.slug) as Enums.ItemSlugs, int(item.qty))
	
	# Update the in-game timer to match the user's save data.
	GameTimer.set_time_start(float(save_dict.game_time))
	
	# Transfer to the scene from the save file.
	var pos_str = (save_dict.player_pos as String).split(",")
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = int(save_dict.scene) as Enums.Scenes
	tele_args.to_location = Vector2(float(pos_str[0]), float(pos_str[1]))
	SignalBus.transfer_player_to_scene.emit(tele_args)
	
	# Fade in the screen.
	Utility.fade_in()

func save_most_recent_slot_meta(slot_number: int):
	var meta_dict: Dictionary = {
		"most_recent_save_slot": slot_number,
	}
	var meta_file = FileAccess.open("user://meta.save", FileAccess.WRITE)
	var json_string = JSON.stringify(meta_dict)
	meta_file.store_line(json_string)

func get_game_time_from_slot(slot_number: int) -> String:
	var file_name = "user://savegame" + str(slot_number) + ".save"
	if (!FileAccess.file_exists(file_name)):
		return GameScript.get_entry("Global.Empty")
	
	# Load the save file.
	var save_game_text = FileAccess.get_file_as_string(file_name)
	var save_dict = JSON.parse_string(save_game_text)
	
	return format_time(float(save_dict.game_time))

func format_time(time_in_sec):
	var iseconds = int(time_in_sec)
	
	@warning_ignore("integer_division")
	var minutes = (iseconds / 60) % 60
	
	@warning_ignore("integer_division")
	var hours = (iseconds / 60) / 60
	
	var h = GameScript.get_entry("Global.Hours_Abbr")
	var m = GameScript.get_entry("Global.Minutes_Abbr")
	
	return str(hours) + h + " " + (("%02d" + m) % [minutes])

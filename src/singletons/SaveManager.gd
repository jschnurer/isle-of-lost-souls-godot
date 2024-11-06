extends Node

var slot = 1

func _ready():
	SignalBus.save_game.connect(_on_save_game)
	SignalBus.load_game.connect(_on_load_game)

func _on_save_game():
	var save_file = FileAccess.open("user://savegame" + str(slot) + ".save", FileAccess.WRITE)
	var player: Player = get_tree().get_first_node_in_group("Player")
	var scene_bg: SceneBG = get_tree().get_first_node_in_group("GameScene")
	
	var save_dict = {
		"player_pos": str(player.position.x) + "," + str(player.position.y),
		"facing": player.facing_dir,
		"scene": scene_bg.scene,
		"inventory": [],
		"vars": GameVars.get_all(),
	}
	
	var inv_items: Array[Item] = Inventory.get_items()
	for item in inv_items:
		var item_dict = {
			"slug": item.slug,
			"qty": item.quantity,
		}
		save_dict.inventory.append(item_dict)
	
	var json_string = JSON.stringify(save_dict)
	save_file.store_line(json_string)
	
	Utility.show_message(GameScript.get_entry("Global.Save_Complete"))

func _on_load_game(slot_number: int):
	slot = slot_number
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
	
	# Transfer to the scene from the save file.
	var pos_str = (save_dict.player_pos as String).split(",")
	
	var tele_args = TeleportArgs.new()
	tele_args.to_scene = int(save_dict.scene) as Enums.Scenes
	tele_args.to_location = Vector2(float(pos_str[0]), float(pos_str[1]))
	SignalBus.transfer_player_to_scene.emit(tele_args)
	
	SignalBus.fade_in_screen.emit(ScreenFadeArgs.new())

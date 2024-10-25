extends Node

var screen_edge_padding_x = 50
var screen_edge_padding_y = 30
var screen_width = 816
var screen_height = 624
var current_scene = Enums.Scenes.FOREST_CLEARING

func _ready():
	SignalBus.connect("transfer_player_to_scene", _on_transfer_player_to_scene)
	transfer_player_to_scene(current_scene, Vector2(150, 390))

# Callback for when the SignalBus is told to transfer the player.
func _on_transfer_player_to_scene(args: TeleportArgs):
	var location = args.to_location
	
	var to_scene = args.to_scene
	var player_info: PlayerInfo = GameVars.get_var(Enums.Vars.PLAYER_INFO);
	
	if (args.to_previous_position):
		location = player_info.position
		to_scene = player_info.scene
	elif (args.to_screen_center == true):
		location.x = 408
		location.y = 312
	else:
		if (args.preserve_x == true):
			var player: CharacterBody2D = get_node("/root/World/Player")
			location.x = player.position.x
		elif (args.to_east == true):
			location.x = screen_edge_padding_x
		elif (args.to_west == true):
			location.x = screen_width - screen_edge_padding_x
			
		if (args.preserve_y == true):
			var player: CharacterBody2D = get_node("/root/World/Player")
			location.y = player.position.y
		elif (args.to_north == true):
			location.y = screen_height - screen_edge_padding_y
		elif (args.to_south == true):
			location.y = screen_edge_padding_y
	
	transfer_player_to_scene(to_scene, location)

# Load a new scene, move the player.
func transfer_player_to_scene(destination: Enums.Scenes, location: Vector2):
	var scene = load(Enums.ScenePaths.get(destination))
	var scene_node = scene.instantiate()
	var scene_holder = get_node("/root/World/SceneHolder")
	
	if (scene_holder.get_children().size() > 0):
		var node_to_remove = scene_holder.get_children()[0]
		scene_holder.call_deferred("remove_child", node_to_remove)
		node_to_remove.queue_free()
	
	scene_holder.call_deferred("add_child", scene_node)
	var player: CharacterBody2D = get_node("/root/World/Player")
	player.set_deferred("position", location)
	
	current_scene = destination

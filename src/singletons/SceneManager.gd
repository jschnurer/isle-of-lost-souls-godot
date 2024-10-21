extends Node

func _ready():
	SignalBus.connect("transfer_player_to_scene", transfer_player_to_scene)
	transfer_player_to_scene(Enums.Scenes.FOREST_CLEARING, Vector2(150, 390))
	
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

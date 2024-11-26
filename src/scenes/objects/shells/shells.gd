@tool
extends Node2D

var _rando: bool = false
@export var randomize_shells: bool:
	get:
		return _rando
	set(value):
		_rando = value
		var child_nodes = get_children()
		for node in child_nodes:
			if node is Shell:
				node.texture = node.textures[randi_range(0, node.textures.size() - 1)]
				node.flip_h = randi_range(0, 1) == 0
				node.rotation_degrees = randi_range(0, 4) * 90

@tool
extends Node2D

var _rando: bool = false
@export var randomize_grass: bool:
	get:
		return _rando
	set(value):
		_rando = value
		var child_nodes = get_children()
		for node in child_nodes:
			if node is BeachGrass:
				node.texture = node.grasses[randi_range(0, node.grasses.size() - 1)]
				node.flip_h = randi_range(0, 1) == 0

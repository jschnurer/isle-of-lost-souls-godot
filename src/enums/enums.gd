extends Node

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

enum ActivationMode {
	ACTIVATE,
	COLLIDE,
	ON_SCENE_START
}

enum EventType {
	DIALOG,
	TELEPORT
}

enum Scenes {
	FOREST_CLEARING,
	FOREST_BRIDGE_SOUTH
}

var ScenePaths = {
	Scenes.FOREST_CLEARING: "res://src/scenes/forest/clearing/Clearing.tscn",
	Scenes.FOREST_BRIDGE_SOUTH: "res://src/scenes/forest/bridge_south/BridgeSouth.tscn"
}

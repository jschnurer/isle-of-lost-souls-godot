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
	FOREST_BRIDGE_SOUTH,
	FOREST_QUIET_FORK,
	FOREST_RIVER_BANK,
	FOREST_HILLTOP
}

var ScenePaths = {
	Scenes.FOREST_CLEARING: "res://src/scenes/forest/clearing/Clearing.tscn",
	Scenes.FOREST_BRIDGE_SOUTH: "res://src/scenes/forest/bridge_south/BridgeSouth.tscn",
	Scenes.FOREST_QUIET_FORK: "res://src/scenes/forest/quiet_fork/QuietFork.tscn",
	Scenes.FOREST_RIVER_BANK: "res://src/scenes/forest/river_bank/RiverBank.tscn",
	Scenes.FOREST_HILLTOP: "res://src/scenes/forest/hilltop/Hilltop.tscn"
}

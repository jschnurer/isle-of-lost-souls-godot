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
	FOREST_HILLTOP,
	FOREST_LONELY_PATH,
	FOREST_QUIET_PATH,
	FOREST_BEND,
	FOREST_ABRUPT_TURN,
	FOREST_RUINS_ENTRANCE,
	FOREST_WELL_WORN_TRAIL,
	FOREST_OLD_WELL,
	FOREST_HIVE_ENTRANCE,
	FOREST_OUTSIDE_CABIN,
	FOREST_PATH_TO_SWAMP,
	RUINS_RUINED_HALL,
	SWAMP_NEAR_FOREST
}

var ScenePaths = {
	Scenes.FOREST_CLEARING: "res://src/scenes/forest/clearing/Clearing.tscn",
	Scenes.FOREST_BRIDGE_SOUTH: "res://src/scenes/forest/bridge_south/BridgeSouth.tscn",
	Scenes.FOREST_QUIET_FORK: "res://src/scenes/forest/quiet_fork/QuietFork.tscn",
	Scenes.FOREST_RIVER_BANK: "res://src/scenes/forest/river_bank/RiverBank.tscn",
	Scenes.FOREST_HILLTOP: "res://src/scenes/forest/hilltop/Hilltop.tscn",
	Scenes.FOREST_LONELY_PATH: "res://src/scenes/forest/lonely_path/LonelyPath.tscn",
	Scenes.FOREST_QUIET_PATH: "res://src/scenes/forest/quiet_path/QuietPath.tscn",
	Scenes.FOREST_BEND: "res://src/scenes/forest/bend/Bend.tscn",
	Scenes.FOREST_ABRUPT_TURN: "res://src/scenes/forest/abrupt_turn/AbruptTurn.tscn",
	Scenes.FOREST_RUINS_ENTRANCE: "res://src/scenes/forest/ruins_entrance/RuinsEntrance.tscn",
	Scenes.FOREST_WELL_WORN_TRAIL: "res://src/scenes/forest/well_worn_trail/WellWornTrail.tscn",
	Scenes.FOREST_OLD_WELL: "res://src/scenes/forest/old_well/OldWell.tscn",
	Scenes.FOREST_HIVE_ENTRANCE: "res://src/scenes/forest/hive_entrance/HiveEntrance.tscn",
	Scenes.FOREST_OUTSIDE_CABIN: "res://src/scenes/forest/outside_cabin/OutsideCabin.tscn",
	Scenes.FOREST_PATH_TO_SWAMP: "res://src/scenes/forest/path_to_swamp/PathToSwamp.tscn",
	Scenes.RUINS_RUINED_HALL: "res://src/scenes/ruins/ruined_hall/RuinedHall.tscn",
	Scenes.SWAMP_NEAR_FOREST: "res://src/scenes/swamp/near_forest/NearForest.tscn"
}

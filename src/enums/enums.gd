extends Node

enum InputMethod { PC, XBOX, }
enum InputAction { COLLIDE, INVESTIGATE, INTERACT, TAKE, USE_ITEM, }
enum Direction { UNSET = 0, UP = 1, DOWN = 2, LEFT = 3, RIGHT = 4, }
enum PlayerMode { PERSON, POINTER }
enum ActivationMode { ACTIVATE, COLLIDE, }
enum EventType { DIALOG, TELEPORT }
enum ChoiceLocation { CENTER, BOTTOM, TOP }

enum Areas {
	CAVES,
	COAST,
	FOREST,
	MEMORIES,
	MOUNTAIN,
	RUINS,
	SWAMP,
}

enum Vars {
	PLAYER_INFO,
	TOOK_STONE,
	DISTRACTED_FISH,
	TOOK_NAIL,
	TOOK_RIVER_ROD,
	ROD_IN_DEVICE,
	RUIN_HALL_DOOR_OPEN,
	RUINED_HOUSE_OPEN,
	HOUSE_CHEST_OPEN,
	TOOK_FLASHLIGHT,
	MOVED_RUG,
	TOOK_POTION,
	SAW_POSTER,
	MOVED_TEMPLE_ALTAR,
	ROD_IN_TEMPLE_DEVICE,
	HATCH_OPEN,
}

enum EngineEvents {
	SHOW_MESSAGE,
	TRANSFER_PLAYER
}

enum ItemSlugs {
	BLIGHT_CURE,
	BOTTLE,
	BOTTLE_OF_WATER,
	BROKENBOX,
	COIN,
	COMPASS,
	ELTNAMSID_RUNE,
	ETAVONER_RUNE,
	FISH_STONE,
	FLASHLIGHT,
	FOLDED_NOTE,
	HATCH_NOTE,
	LIEVNU_RUNE,
	LIGHTHOUSE_KEY,
	MAP,
	MEREDITH_NOTE1,
	MOLDY_NOTE,
	MOSQUITO_EGG,
	NAIL,
	OPHELIAS_JOURNAL1,
	OPHELIAS_JOURNAL2,
	PARCHMENT,
	POTION,
	PUFFBALL,
	RAINBOW_SHELL,
	RED_FABRIC,
	RUINS_ROD,
	SAC,
	SCISSORS,
	SILVERBOX,
	SLEDGE,
	TARNROOT,
}

enum TopicGroups {
	GLOBAL = 1,
	ARDEN = 2,
	RHODE = 3,
}

enum Topics {
	WHO_ARE_YOU = 1,
	GOODBYE = 2,
	MY_PAST = 3,
	ISLAND_ARRIVAL = 4,
	MEREK = 5,
	TOTEMS = 6,
	FAIR_HAIRED_WOMAN = 7,
}

enum Scenes {
	CAVES_BAT_DEN = 13,
	CAVES_BOTTOM_OF_SHAFT = 14,
	CAVES_CACHE = 15,
	CAVES_CHASM = 16,
	CAVES_COAST_EXIT = 17,
	CAVES_FOREST_EXIT = 18,
	CAVES_LAB_EXIT = 19,
	CAVES_MOIST_CAVERN = 20,
	CAVES_MUSHROOMS = 21,
	CAVES_NARROW_PASSAGE = 22,
	CAVES_PIT_CHAMBER = 23,
	CAVES_PRECARIOUS_LEDGE = 24,
	CAVES_SUNLESS_LAKE = 25,
	CAVES_TEMPLE_EXIT = 26,
	CAVES_WEIGHT_PUZZLE = 27,
	
	COAST_BEACH_CENTRAL = 28,
	COAST_BEACH_EAST = 29,
	COAST_BEACH_WEST = 30,
	COAST_BIRD_NEST = 31,
	COAST_DUNES = 32,
	COAST_LIGHTHOUSE_1F = 33,
	COAST_LIGHTHOUSE_2F = 34,
	COAST_LIGHTHOUSE_EXTERIOR = 35,
	COAST_LIGHTHOUSE_LIGHT = 36,
	COAST_PENINSULA = 37,
	COAST_ROCKY_CLIFFSIDE = 38,
	COAST_ROCKY_INCLINE = 39,
	COAST_ROCKY_TRAIL = 40,
	COAST_SHALLOW_BAY = 41,
	
	FOREST_ABRUPT_TURN = 9,
	FOREST_BEND = 8,
	FOREST_BRIDGE_NORTH = 42,
	FOREST_BRIDGE_SOUTH = 2,
	FOREST_CABIN_EXTERIOR = 43,
	FOREST_CABIN_INTERIOR = 44,
	FOREST_CAVE_ENTRANCE = 45,
	FOREST_CLEARING = 1,
	FOREST_CLEARING_HOLE = 46,
	FOREST_HILLTOP = 5,
	FOREST_HIVE = 47,
	FOREST_HIVE_ENTRANCE = 48,
	FOREST_HIVE_QUEEN = 49,
	FOREST_LONELY_PATH = 6,
	FOREST_OLD_WELL = 12,
	FOREST_QUIET_FORK = 3,
	FOREST_QUIET_PATH = 7,
	FOREST_RIVER_BANK = 4,
	FOREST_RUINS_ENTRANCE = 10,
	FOREST_SWAMP_ENTRANCE = 50,
	FOREST_WELL_CAVE = 51,
	FOREST_WELL_WORN_TRAIL = 11,
	
	MEMORIES_ARDEN = 52,
	MEMORIES_EDRA = 53,
	MEMORIES_MEREDITH = 54,
	MEMORIES_MEREK = 55,
	MEMORIES_OPHELIA = 56,
	MEMORIES_RHODE = 57,
	MEMORIES_STANLEY = 58,
	
	MOUNTAINS_CAMPSITE = 59,
	MOUNTAINS_CAVES_ENTRANCE = 60,
	MOUNTAINS_GRAND_STEPS = 61,
	MOUNTAINS_LAKE = 62,
	MOUNTAINS_MAZE_CENTER = 63,
	MOUNTAINS_MAZE_GOAL = 64,
	MOUNTAINS_MAZE_NORTH = 65,
	MOUNTAINS_MAZE_SOUTH = 66,
	MOUNTAINS_MAZE = 67,
	MOUNTAINS_STEEP_ROCKY_INCLINE = 68,
	MOUNTAINS_SUMMIT = 69,
	MOUNTAINS_WINDING_PATH = 70,
	
	RUINS_BUNKER = 71,
	RUINS_LAB = 72,
	RUINS_HALL = 73,
	RUINS_HOUSE = 74,
	RUINS_SQUARE_NORTH = 75,
	RUINS_SQUARE_SOUTH = 76,
	RUINS_TEMPLE_SOUTH = 77,
	
	SWAMP_BUBBLING_MUCK = 78,
	SWAMP_CAMPSITE = 79,
	SWAMP_DEAD_TREE = 80,
	SWAMP_DRY_TRAIL = 81,
	SWAMP_FOREST_ENTRANCE = 82,
	SWAMP_HUT_INTERIOR = 83,
	SWAMP_HUT_EXTERIOR = 84,
	SWAMP_MAMMOTH_SKULL = 85,
	SWAMP_MOSQUITO_SPAWN = 86,
	SWAMP_RIDGE = 87,
	SWAMP_STANDING_WATER = 88,
	SWAMP_STATUE = 89,
	SWAMP_TOPPLED_LOG = 90,
	
	GAME_OVER_FISH = 91,
	FOREST_QUIET_FORK_SIGNPOST = 92,
	GAME_OVER_GRUE = 93,
	RUINS_HOUSE_CHEST = 94,
	TITLE_SCREEN = 95,
	RUINS_TEMPLE_NORTH = 96,
}

var ScenePaths = {
	Scenes.CAVES_BAT_DEN: "res://src/scenes/caves/",
	Scenes.CAVES_BOTTOM_OF_SHAFT: "res://src/scenes/caves/",
	Scenes.CAVES_CACHE: "res://src/scenes/caves/",
	Scenes.CAVES_CHASM: "res://src/scenes/caves/",
	Scenes.CAVES_COAST_EXIT: "res://src/scenes/caves/",
	Scenes.CAVES_FOREST_EXIT: "res://src/scenes/caves/",
	Scenes.CAVES_LAB_EXIT: "res://src/scenes/caves/",
	Scenes.CAVES_MOIST_CAVERN: "res://src/scenes/caves/",
	Scenes.CAVES_MUSHROOMS: "res://src/scenes/caves/",
	Scenes.CAVES_NARROW_PASSAGE: "res://src/scenes/caves/",
	Scenes.CAVES_PIT_CHAMBER: "res://src/scenes/caves/",
	Scenes.CAVES_PRECARIOUS_LEDGE: "res://src/scenes/caves/",
	Scenes.CAVES_SUNLESS_LAKE: "res://src/scenes/caves/",
	Scenes.CAVES_TEMPLE_EXIT: "res://src/scenes/caves/",
	Scenes.CAVES_WEIGHT_PUZZLE: "res://src/scenes/caves/",

	Scenes.COAST_BEACH_CENTRAL: "res://src/scenes/coast/",
	Scenes.COAST_BEACH_EAST: "res://src/scenes/coast/",
	Scenes.COAST_BEACH_WEST: "res://src/scenes/coast/",
	Scenes.COAST_BIRD_NEST: "res://src/scenes/coast/",
	Scenes.COAST_DUNES: "res://src/scenes/coast/",
	Scenes.COAST_LIGHTHOUSE_1F: "res://src/scenes/coast/",
	Scenes.COAST_LIGHTHOUSE_2F: "res://src/scenes/coast/",
	Scenes.COAST_LIGHTHOUSE_EXTERIOR: "res://src/scenes/coast/",
	Scenes.COAST_LIGHTHOUSE_LIGHT: "res://src/scenes/coast/",
	Scenes.COAST_PENINSULA: "res://src/scenes/coast/",
	Scenes.COAST_ROCKY_CLIFFSIDE: "res://src/scenes/coast/",
	Scenes.COAST_ROCKY_INCLINE: "res://src/scenes/coast/",
	Scenes.COAST_ROCKY_TRAIL: "res://src/scenes/coast/",
	Scenes.COAST_SHALLOW_BAY: "res://src/scenes/coast/",
	
	Scenes.FOREST_ABRUPT_TURN: "res://src/scenes/forest/abrupt_turn/AbruptTurn.tscn",
	Scenes.FOREST_BEND: "res://src/scenes/forest/bend/Bend.tscn",
	Scenes.FOREST_BRIDGE_NORTH: "res://src/scenes/forest/",
	Scenes.FOREST_BRIDGE_SOUTH: "res://src/scenes/forest/bridge_south/BridgeSouth.tscn",
	Scenes.FOREST_CABIN_EXTERIOR: "res://src/scenes/forest/cabin_exterior/CabinExterior.tscn",
	Scenes.FOREST_CABIN_INTERIOR: "res://src/scenes/forest/",
	Scenes.FOREST_CAVE_ENTRANCE: "res://src/scenes/forest/",
	Scenes.FOREST_CLEARING: "res://src/scenes/forest/clearing/Clearing.tscn",
	Scenes.FOREST_CLEARING_HOLE: "res://src/scenes/forest/clearing/sub_areas/hole/Hole.tscn",
	Scenes.FOREST_HILLTOP: "res://src/scenes/forest/hilltop/Hilltop.tscn",
	Scenes.FOREST_HIVE: "res://src/scenes/forest/",
	Scenes.FOREST_HIVE_ENTRANCE: "res://src/scenes/forest/hive_entrance/HiveEntrance.tscn",
	Scenes.FOREST_HIVE_QUEEN: "res://src/scenes/forest/",
	Scenes.FOREST_LONELY_PATH: "res://src/scenes/forest/lonely_path/LonelyPath.tscn",
	Scenes.FOREST_OLD_WELL: "res://src/scenes/forest/old_well/OldWell.tscn",
	Scenes.FOREST_QUIET_FORK: "res://src/scenes/forest/quiet_fork/QuietFork.tscn",
	Scenes.FOREST_QUIET_FORK_SIGNPOST: "res://src/scenes/forest/quiet_fork/interactables/forest_quiet_fork_signpost.tscn",
	Scenes.FOREST_QUIET_PATH: "res://src/scenes/forest/quiet_path/QuietPath.tscn",
	Scenes.FOREST_RIVER_BANK: "res://src/scenes/forest/river_bank/RiverBank.tscn",
	Scenes.FOREST_RUINS_ENTRANCE: "res://src/scenes/forest/ruins_entrance/RuinsEntrance.tscn",
	Scenes.FOREST_SWAMP_ENTRANCE: "res://src/scenes/forest/swamp_path/swamp_path.tscn",
	Scenes.FOREST_WELL_CAVE: "res://src/scenes/forest/cave_of_bones/CaveOfBones.tscn",
	Scenes.FOREST_WELL_WORN_TRAIL: "res://src/scenes/forest/well_worn_trail/WellWornTrail.tscn",

	Scenes.MEMORIES_ARDEN: "res://src/scenes/memories/",
	Scenes.MEMORIES_EDRA: "res://src/scenes/memories/",
	Scenes.MEMORIES_MEREDITH: "res://src/scenes/memories/",
	Scenes.MEMORIES_MEREK: "res://src/scenes/memories/",
	Scenes.MEMORIES_OPHELIA: "res://src/scenes/memories/",
	Scenes.MEMORIES_RHODE: "res://src/scenes/memories/",
	Scenes.MEMORIES_STANLEY: "res://src/scenes/memories/",

	Scenes.MOUNTAINS_CAMPSITE: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_CAVES_ENTRANCE: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_GRAND_STEPS: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_LAKE: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_MAZE_CENTER: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_MAZE_GOAL: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_MAZE_NORTH: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_MAZE_SOUTH: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_MAZE: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_STEEP_ROCKY_INCLINE: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_SUMMIT: "res://src/scenes/mountains/",
	Scenes.MOUNTAINS_WINDING_PATH: "res://src/scenes/mountains/",

	Scenes.RUINS_BUNKER: "res://src/scenes/ruins/hatch_interior/hatch_interior.tscn",
	Scenes.RUINS_LAB: "res://src/scenes/ruins/lab/ruined_lab.tscn",
	Scenes.RUINS_HALL: "res://src/scenes/ruins/ruined_hall/ruined_hall.tscn",
	Scenes.RUINS_HOUSE: "res://src/scenes/ruins/home/Home.tscn",
	Scenes.RUINS_HOUSE_CHEST: "res://src/scenes/ruins/ruined_house_chest/ruined_house_chest.tscn",
	Scenes.RUINS_SQUARE_NORTH: "res://src/scenes/ruins/square_north/square_north.tscn",
	Scenes.RUINS_SQUARE_SOUTH: "res://src/scenes/ruins/square_south/SquareSouth.tscn",
	Scenes.RUINS_TEMPLE_SOUTH: "res://src/scenes/ruins/grand_temple_south/grand_temple_south.tscn",
	Scenes.RUINS_TEMPLE_NORTH: "res://src/scenes/ruins/grand_temple_north/grand_temple_north.tscn",

	Scenes.SWAMP_BUBBLING_MUCK: "res://src/scenes/swamp/",
	Scenes.SWAMP_CAMPSITE: "res://src/scenes/swamp/",
	Scenes.SWAMP_DEAD_TREE: "res://src/scenes/swamp/",
	Scenes.SWAMP_DRY_TRAIL: "res://src/scenes/swamp/",
	Scenes.SWAMP_FOREST_ENTRANCE: "res://src/scenes/swamp/",
	Scenes.SWAMP_HUT_INTERIOR: "res://src/scenes/swamp/",
	Scenes.SWAMP_HUT_EXTERIOR: "res://src/scenes/swamp/",
	Scenes.SWAMP_MAMMOTH_SKULL: "res://src/scenes/swamp/",
	Scenes.SWAMP_MOSQUITO_SPAWN: "res://src/scenes/swamp/",
	Scenes.SWAMP_RIDGE: "res://src/scenes/swamp/",
	Scenes.SWAMP_STANDING_WATER: "res://src/scenes/swamp/",
	Scenes.SWAMP_STATUE: "res://src/scenes/swamp/",
	Scenes.SWAMP_TOPPLED_LOG: "res://src/scenes/swamp/",
	
	Scenes.GAME_OVER_FISH: "res://src/scenes/game_overs/fish/fish_game_over.tscn",
	Scenes.GAME_OVER_GRUE: "res://src/scenes/game_overs/grue/grue_game_over.tscn",
	
	Scenes.TITLE_SCREEN: "res://src/scenes/title/title_screen.tscn",
}

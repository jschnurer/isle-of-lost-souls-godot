extends Node

# This script is globally loaded last. Use it to initialize variables, positions, send events,
# etc. for debug purposes. Before shipping the game, remove this file completely.

func _ready():
	# Kill the splash screens
	var splash_screens = get_node_or_null("/root/SplashScreens")
	if (splash_screens):
		splash_screens.queue_free()
		
		var slugs = Enums.ItemSlugs.values().map(func(key): return key)
		for slug in slugs:
			Inventory.add_item(slug)
		
		#Inventory.add_item(Enums.ItemSlugs.RUINS_ROD)
		#Inventory.add_item(Enums.ItemSlugs.SLEDGE)
		#Inventory.add_item(Enums.ItemSlugs.FLASHLIGHT)
		#Inventory.add_item(Enums.ItemSlugs.MAP)
		GameVars.set_var(Enums.Vars.RUIN_HALL_DOOR_OPEN, true)
		
		Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.CURE)
		
		await Utility.wait(.1)
		
		var args = TogglePlayerArgs.new()
		args.is_controllable = true
		args.is_visible = true
		SignalBus.toggle_player.emit(args)
		
		var tele_args = TeleportArgs.new()
		tele_args.to_scene = Enums.Scenes.SWAMP_MAMMOTH_SKULL
		tele_args.to_location = Vector2(417, 338)
		SignalBus.transfer_player_to_scene.emit(tele_args)
		
	pass

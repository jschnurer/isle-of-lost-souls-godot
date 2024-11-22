extends BaseItemUsage

func use_item():
	var curr_scene = Utility.get_curr_area()
	
	if (curr_scene == Enums.Scenes.MOUNTAINS_MAZE):
		var step = GameVars.get_var(Enums.Vars.MAZE_STEP, 0)
		match step:
			0: Utility.msg("Items.Map.Go_North")
			1: Utility.msg("Items.Map.Go_East")
			2: Utility.msg("Items.Map.Go_North")
			3: Utility.msg("Items.Map.Go_South")
			4: Utility.msg("Items.Map.Go_South")
			5: Utility.msg("Items.Map.Go_West")
			6: Utility.msg("Items.Map.Go_South")
			7: Utility.msg("Items.Map.Go_East")
			8: Utility.msg("Items.Map.Go_North")
			9: Utility.msg("Items.Map.Go_East")
			
	elif (curr_scene == Enums.Scenes.MOUNTAINS_MAZE_CENTER
		or curr_scene == Enums.Scenes.MOUNTAINS_MAZE_NORTH
		or curr_scene == Enums.Scenes.MOUNTAINS_MAZE_SOUTH):
		# Say to go east or west randomly.
		var roll = randi_range(0, 1)
		if (roll == 1):
			Utility.msg("Items.Map.Go_East")
		else:
			Utility.msg("Items.Map.Go_West")
			
	elif (curr_scene == Enums.Scenes.MOUNTAINS_MAZE_GOAL):
		Utility.msg("Items.Map.Red_X")
		
	else:
		Utility.msg("Items.Map.Use_Wrong_Area")

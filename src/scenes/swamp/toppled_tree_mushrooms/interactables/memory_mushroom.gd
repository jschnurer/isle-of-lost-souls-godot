extends BaseEvent

@export var color: String = ""

var req_sequences = {
	"Blue": 0,
	"Yellow": 1,
	"Red": 2,
	"Purple": 3,
	"Orange": 4,
	"Green": 5,
	"Indigo": 6,
}

func investigate():
	Utility.msg("Swamp.Toppled_Tree.Mushroom_Look_" + color)

func interact():
	if (not GameVars.get_var(Enums.Vars.MUSHROOMS_ANCHORED)):
		await Utility.msg("Swamp.Toppled_Tree.Mushroom_Touch_Moves", true)
		Utility.msg("Swamp.Toppled_Tree.Mushroom_Hint")
	else:
		var curr_seq = GameVars.get_var(Enums.Vars.MUSHROOM_TOUCH_SEQUENCE)
		
		if (curr_seq == null):
			curr_seq = 0
			
		var req_seq = req_sequences[color]
		
		if (req_seq == curr_seq):
			# Touch OK!
			GameVars.set_var(Enums.Vars.MUSHROOM_TOUCH_SEQUENCE, curr_seq + 1)
			
			if (curr_seq + 1 == 7):
				# Final mushroom activated!
				Utility.msg("Swamp.Toppled_Tree.Mushroom_Interact_Glow_Final")
			else:
				Utility.msg("Swamp.Toppled_Tree.Mushroom_Interact_Glow")
		else:
			Utility.initiate_game_over(Enums.Scenes.GAME_OVER_MUSHROOM, .5)

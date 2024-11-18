extends BaseEvent

func investigate():
	await Utility.msg("Swamp.Toppled_Tree.Log_Look")
	Utility.go_to_sub_area(Enums.Scenes.SWAMP_TOPPLED_TREE_MUSHROOMS)

extends BaseEvent

func investigate():
	await Utility.msg("Swamp.Abandoned_Campsite.Tent_Look")
	Utility.go_to_sub_area(Enums.Scenes.SWAMP_CAMPSITE_TENT)

func take():
	Utility.msg("Swamp.Abandoned_Campsite.Tent_Take")

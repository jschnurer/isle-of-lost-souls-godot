extends BaseEvent

func investigate():
	await Utility.msg("Coast.Beach_East.Canoe_Look")
	Utility.go_to_sub_area(Enums.Scenes.COAST_CANOE)

func take():
	Utility.msg("Coast.Beach_East.Canoe_Take")

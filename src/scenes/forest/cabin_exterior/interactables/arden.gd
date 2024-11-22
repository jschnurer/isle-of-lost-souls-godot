extends BaseEvent

func investigate():
	await Utility.msg("Forest.Cabin_Exterior.Arden_Look", true)
	Utility.msg("Forest.Cabin_Exterior.Arden_Look_2")

func interact():
	var choice = await Utility.yes_no_choice_msg("Forest.Cabin_Exterior.Arden_Interact")
	
	if (choice.index == 1):
		await Utility.msg("Forest.Cabin_Exterior.Arden_No_Nail")
	else:
		await Utility.msg("Forest.Cabin_Exterior.Arden_Lie_About_Nail")

func take():
	Utility.msg("Forest.Cabin_Exterior.Arden_Take")

extends BaseEvent

func investigate():
	if (get_parent()._type == Enums.BushTypes.BUSH):
		Utility.msg("Common_Objects.Bushes_Look")
	elif (get_parent()._type == Enums.BushTypes.BRAMBLES):
		Utility.msg("Common_Objects.Brambles_Look")
		
func take():
	if (get_parent()._type == Enums.BushTypes.BUSH):
		Utility.msg("Common_Objects.Bushes_Take")
	elif (get_parent()._type == Enums.BushTypes.BRAMBLES):
		Utility.msg("Common_Objects.Brambles_Take")

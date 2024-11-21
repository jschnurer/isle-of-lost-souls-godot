extends BaseEvent

func investigate():
	Utility.msg("Swamp.Hut_Interior.Map_Look")
	Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.MAP)

func take():
	Utility.msg("Swamp.Hut_Interior.Take_No_Permission")

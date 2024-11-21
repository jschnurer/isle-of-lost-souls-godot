extends BaseEvent

func investigate():
	Utility.msg("Swamp.Hut_Interior.Cellphone_Look")
	Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.CELLPHONE)

func take():
	Utility.msg("Swamp.Hut_Interior.Take_No_Permission")

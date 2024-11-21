extends BaseEvent

func investigate():
	await Utility.msg("Swamp.Hut_Interior.Sword_Look", true)
	Utility.msg("Swamp.Hut_Interior.Shield_Look")
	Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.SWORD)
	Utility.learn_topic(Enums.TopicGroups.RHODE, Enums.Topics.SHIELD)

func take():
	Utility.msg("Swamp.Hut_Interior.Take_No_Permission")

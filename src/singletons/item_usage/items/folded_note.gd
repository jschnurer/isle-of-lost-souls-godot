extends BaseItemUsage

func use_item():
	Utility.msg("Items.Folded_Note.Read")
	Utility.learn_topic(Enums.TopicGroups.GLOBAL, Enums.Topics.MEREDITH)

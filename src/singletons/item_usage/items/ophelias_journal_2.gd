extends BaseItemUsage

func use_item():
	await Utility.msg("Items.Ophelias_Journal_2.Cover", true)
	await Utility.msg("Items.Ophelias_Journal_2.Passage1", true)
	await Utility.msg("Items.Ophelias_Journal_2.Passage2")

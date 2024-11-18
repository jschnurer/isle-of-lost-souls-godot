extends BaseItemUsage

func use_item():
	await Utility.msg("Items.Ophelias_Journal.Cover", true)
	await Utility.msg("Items.Ophelias_Journal.Passage1", true)
	await Utility.msg("Items.Ophelias_Journal.Passage2")

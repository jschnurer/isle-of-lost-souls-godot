extends Node

var known_topics: Dictionary = {
	Enums.TopicGroups.GLOBAL: [Enums.Topics.WHO_ARE_YOU, Enums.Topics.GOODBYE],
	Enums.TopicGroups.ARDEN: [],
	Enums.TopicGroups.RHODE: [Enums.Topics.TOTEMS],
}

var enum_keys = Enums.Topics.keys()

func _ready():
	SignalBus.learn_topic.connect(_on_learn_topic)

func get_topic_text(var_name: Enums.Topics):
	return GameScript.get_entry(Utility.enum_str_to_title_case(enum_keys[var_name]))

func get_item_index(group: Enums.TopicGroups, topic: Enums.Topics):
	for index in known_topics[group].size():
		if (known_topics[group][index] == topic):
			return index
	return -1

func _on_learn_topic(group: Enums.TopicGroups, topic: Enums.Topics):
	var existing_index = get_item_index(group, topic)
	if (existing_index == -1):
		known_topics[group].append(topic)
		SignalBus.on_topic_learned.emit(group, topic)

func remove_item(group: Enums.TopicGroups, topic: Enums.Topics):
	var existing_index = get_item_index(group, topic)
	if (existing_index == -1):
		return
	
	known_topics[group].remove_at(existing_index)

func get_available_topics(group: Enums.TopicGroups, include_global = true) -> Array[DialogTopic]:
	var topic_data: Array[DialogTopic] = []
	
	if (include_global):
		for topic in known_topics[Enums.TopicGroups.GLOBAL]:
			var dialog_topic = DialogTopic.new()
			dialog_topic.slug = topic
			dialog_topic.text = get_topic_text(topic)
			topic_data.append(dialog_topic)

	for topic in known_topics[group]:
		var already_in_list = false
		
		for existing_topic in topic_data:
			if (existing_topic.slug == topic):
				already_in_list = true
				break
		
		if (!already_in_list):
			var dialog_topic = DialogTopic.new()
			dialog_topic.slug = topic
			dialog_topic.text = get_topic_text(topic)
			topic_data.append(dialog_topic)
	
	topic_data.sort_custom(sort_dialog_topics)
	return topic_data

func sort_dialog_topics(a: DialogTopic, b: DialogTopic):
	return a.text.to_lower() < b.text.to_lower()

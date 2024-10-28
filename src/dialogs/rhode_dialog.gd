extends "res://src/dialogs/base_dialog.gd"

func _ready():
	topic_group = Enums.TopicGroups.RHODE

func ask_about(topic: Enums.Topics):
	if (topic == Enums.Topics.WHO_ARE_YOU):
		SignalBus.show_dialog_message.emit("\"My name is Rhode and thou art the first person that I have laid eyes upon in a long time.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"Doest thou have any specific questions or wouldst thou like to hear about my past?\"", false)
		SignalBus.learn_topic.emit(Enums.TopicGroups.RHODE, Enums.Topics.MY_PAST)
	
	elif (topic == Enums.Topics.MY_PAST):
		SignalBus.show_dialog_message.emit("\"'Tis true, as thou might have guessed, that I am a witch. An occultist. A thaumaturge. It doth not matter what name others give unto me, 'tis all the same.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"I harness powers from the great beyond to shape reality.\" She pauses and smiles. \"In other words, I use magic.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"I once lived near a small village; Its name doth escape me now. 'Twas there that I worked my trade. Under my care, the sick were cured, crops flourished, and healthy babies were born.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"'Tis true that most in the village believed that I performed the black arts of the devil and such nonsense, but there were some that were grateful. I lived unmolested there for many years.\"", true) 
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("She shifts uncomfortably. \"Then one day a witch hunter came from the Order of...\" She pauses. \"Hmm. I seem to have forgotten. Anyway, a witch hunter had come for me.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"He invaded my home with hate and fear and murder in his eyes. He ran his cold steel through my belly with naught a word.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"But as I lay upon the floor with my humours spreading out about me, he finally spake.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"He said to me 'Thy soul shalt be condemned to that faraway place, the island of the lost'.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("She takes a deep breath before continuing her story.", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"Then, I recall waking on this island with naught but vague memories of before and no worse for wear. I wandered for a bit, searching for others.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"Wouldst thou believe it? The first person I met was none other than the man who had tried to slay me! He took up his arms against me but he had not the will to slay me.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"For we were the only ones on the island as far as we knew and the prospect of being alone was the greater spectre in his eyes.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"We explored together and slowly a... bond formed. I learned his name was Merek. He was a young recruit of his Order and was eager to prove himself. How we ended up here, neither of us knew.\"", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"Eventually we met another. A woman of fair hair and stoic demeanor.\" She pauses again, scrunching her brow, trying to recall distant memories.", true)
		await SignalBus.dialog_message_closed
		SignalBus.show_dialog_message.emit("\"I'm sorry. This story of mine is at its end, for I can recall no more.\"", false)
	
	else:
		super.ask_about(topic)
	
func on_greet():
	SignalBus.show_dialog_message.emit("Yes? What doest thou want?", false)

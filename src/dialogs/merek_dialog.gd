extends BaseDialog

func on_greet():
	Utility.dialog_msg("Dialog.Merek.Greet")
	
func ask_about(topic: Enums.Topics):
	match topic:
		Enums.Topics.GOODBYE:
			Utility.close_dialog()
		Enums.Topics.WHO_ARE_YOU:
			Utility.dialog_msg("Dialog.Merek.Who_Are_You")
		Enums.Topics.MEREDITH:
			Utility.dialog_msg("Dialog.Merek.Meredith")
		Enums.Topics.ARDEN:
			Utility.dialog_msg("Dialog.Merek.Arden")
		Enums.Topics.EDRA:
			Utility.dialog_msg("Dialog.Merek.Edra")
		Enums.Topics.RHODE:
			Utility.dialog_msg("Dialog.Merek.Rhode")
		Enums.Topics.OPHELIA:
			Utility.dialog_msg("Dialog.Merek.Ophelia")
		Enums.Topics.STANLEY:
			Utility.dialog_msg("Dialog.Merek.Stanley")
		Enums.Topics.MEREK:
			Utility.dialog_msg("Dialog.Merek.Merek")
		Enums.Topics.ORDER_OF_THE_GRIFFIN:
			Utility.dialog_msg("Dialog.Merek.Order_of_the_Griffin")
		Enums.Topics.TEMPLE:
			Utility.dialog_msg("Dialog.Merek.Temple")
		Enums.Topics.ISLAND:
			Utility.dialog_msg("Dialog.Merek.Island")
		Enums.Topics.IT:
			Utility.dialog_msg("Dialog.Merek.It")

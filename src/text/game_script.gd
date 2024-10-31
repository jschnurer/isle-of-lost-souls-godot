extends Node

############ GLOBAL TEXTS ############

var Global_You_Cant = "You can't do that."
var Global_No_Effect = "No effect."
var Global_Uninteresting = "It's not very interesting."
var Global_Dont_Take = "Take it would be pointless. You decide to leave it."
var Global_No_Mechanism_To_Interact = "It has no mechanism to interact with."
var Global_Cairn_Take = "Somehow, like a half-remembered memory, you feel that moving the cairn would be detrimental to your progress."
var Global_Cairn_Look = "The cairn stands about 3 feet fall. The stones are covered in runic markings."
var Global_Cairn_Interact = "You reach out and gingerly and respectfully touch the cairn. For just a moment you feel at peace--like everything is going to be OK. A new runic symbol slowly etches itself onto one of the stones."
var Global_Yes = "Yes"
var Global_No = "No"

############ SCENE-SPECIFIC TEXTS ############
###### Forest
## Clearing
# Hole
var Forest_Clearing_Hole_Look = "It's a small hole in the dirt."
var Forest_Clearing_Hole_Take = "It's a hole. By definition, you cannot take it."
# Stone
var Forest_Clearing_Hole_Stone_Look = "It's a small, smooth stone."
var Forest_Clearing_Hole_Stone_Take = "You take the stone."
# Dirt Pile
var Forest_Clearing_Dirt_Look = "It's a little pile of soft soil. It must be from the hole next to it."
var Forest_Clearing_Dirt_Take = "Thinking it over, you decide the dirt would be pointless to take."

## Bridge South
# Bridge
var Forest_Bridge_South_Bridge_Look = "A mighty stone bridge once spanned the river but has since mostly collapsed. Part of it still juts out from either side of the river."
var Forest_Bridge_South_Bridge_Take = "Thinking about carrying this entire bridge away makes your back hurt."
# River
var Forest_Bridge_South_River_Look = "The rushing water is a little murky. You can see dark shapes moving around in it."
var Forest_Bridge_South_River_Take = "Holding an entire river in your hands seems problematic."
# Rusty Rod
var Forest_Bridge_South_Rod_Look = "A cylindrical, rusty metal rod sticks out of the water about 5 feet from the shore."
var Forest_Bridge_South_Rod_Take_Successful = "You wade out into the river and grab the metal rod. You give it a tug but it's caught in the rocks. You work it back and forth until it's free and then make your way back to the bank."

## Quiet Fork
# Signpost
var Forest_Quiet_Fork_Signpost_Look_With_Nail = "A rotting chunk of wood that must have once been a signpost decays in the long grass. It's been rotting away for a long, long time. The single nail that holds it together is rusty but still doing its job."
var Forest_Quiet_Fork_Signpost_Look_Without_Nail = "A rotting chunk of wood that must have once been a signpost decays in the long grass. It's been rotting away for a long, long time."
var Forest_Quiet_Fork_Signpost_Take = "You have no need of an armload of rotten planks."
var Forest_Quiet_Fork_Nail_Look = "It's a rusty old nail. The hole it's in is rotting away and it looks quite loose."
var Forest_Quiet_Fork_Nail_Take = "You get your fingernails under the head of the nail and give it a good couple tugs. Eventually, you work it out of the signpost and take it with you."

## Cabin Exterior
# Garden
var Forest_Cabin_Exterior_Garden_Look = "The garden is well kept and has lots of different things growing in it. You can see carrots, cabbage, peas, tomatoes, and some others you don't recognize."
var Forest_Cabin_Exterior_Garden_Take = "You're not hungry enough to steal someone else's crops."
# Cabin
var Forest_Cabin_Exterior_Cabin_Look = "It's a roughly built log cabin but it seems sturdy enough. There's a door and some shuttered windows around the side."
# Door
var Forest_Cabin_Exterior_Door_Look = "It's a sturdy door constructed of rough lumber."
# Fence
var Forest_Cabin_Exterior_Fence_Look = "It's a simple wooden fence. It completely surrounds the cabin, yard, and garden."
# Arden
var Forest_Cabin_Exterior_Arden_Look = "He's an older man with graying hair and a crudely trimmed gray beard. He's wearing a ratty old brown jacket. With one hand he's holding a new board up to the fence and in the other he's holding a hammer."
var Forest_Cabin_Exterior_Arden_Look_2 = "The new board is only attached to the fence on one end. He's grumbling to himself. \"How does this sort of thing always happen? One single nail short of finishing the job.\""
var Forest_Cabin_Exterior_Arden_Take = "T-that would be kidnapping!"
var Forest_Cabin_Exterior_Arden_Interact = "The man turns toward you. \"Oh, hello there! The name's Arden. We haven't seen any new arrivals in a long, long time. Sorry, but I can't talk now, I have to finish mending this fence. You wouldn't happen to have any nails on you, would you?\""
var Forest_Cabin_Exterior_Arden_No_Nail = "\"Well that's a shame. If you find any, I'd really appreciate one.\""

###### Game Overs
## Fish Game Over
var Game_Over_Fish_1 = "You wade out into the river and grab the metal rod. You give it a tug but it's caught in the rocks."
var Game_Over_Fish_2 = "You start working it back and forth to free it when you feel a stabbing pain in your leg! It's quickly followed by another and another and another!"
var Game_Over_Fish_3 = "The murky water begins to roil as the river reddens with your blood. Gray, toothy fish begin leaping from the water in a feeding frenzy, taking chunks of your flesh before returning to the murky river."
var Game_Over_Fish_4 = "You flee back to the bank of the river but it's too late."
var Game_Over_Fish_5 = "Your head begins spinning. As everything fades to black, you have one, final thought..."
var Game_Over_Fish_6 = "If only you had done something to distract the fish..."

var Game_Over_Grue_1 = "You fumble around in the dark for a few moments. You think you hear something so you immediately stop what you're doing, ears attuned to the silence all around you. Did you really hear something or are your ears playing tricks on you? Your question is answered only a few seconds later."
var Game_Over_Grue_2 = "The sound of slapping feet approaches, its direction indeterminate! Claws dig into your flesh and something large and leathery wraps long, spindly arms around you. You struggle to free yourself but its strength far, far, surpasses your own. You let out a scream as it bites down on your neck."
var Game_Over_Grue_3 = "You should fear the dark..."
############ DIALOGS ############

###### Topics
var Topic_Who_Are_You = "Who are you?"
var Topic_Goodbye = "goodbye"
var Topic_My_Past = "my past"
var Topic_Island_Arrival = "island arrival"
var Topic_Merek = "Merek"
var Topic_Totems = "totems"
var Topic_Fair_Haired_Woman = "fair-haired woman"

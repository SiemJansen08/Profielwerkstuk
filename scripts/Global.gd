extends Node

func _physics_process(delta):
	questlevels()
	questvis()

var game_first_load = true			# for scene transitions

var player_current_attack = false		#attack stuff
var stealth_mode = false

var current_scene = "world"			# scene transitions
var transition_scene = false

var player_exit_cave_posx = 376			# in and out cords of cave scene
var player_exit_cave_posy = -49
var player_start_posx = -578
var player_start_posy = -108

var bridge_acces = false			# level progression
var cave_acces = false
var cave_win = false

var current_wave: int
var moving_to_next_wave: bool

var questlevel = 1
var current_quest_title
var current_quest_desc

func questlevels():
	if questlevel == 1:
		current_quest_title = "Lip"
		current_quest_desc = "Find Lip and speak with him"
	elif questlevel == 2:
		current_quest_title = "Cave"
		current_quest_desc = "Explore the cave inthe North"
	elif questlevel == 3:
		current_quest_title = "Inklings"
		current_quest_desc = "Kill all the Inklings"
	elif questlevel == 4:
		current_quest_title = "Lip"
		current_quest_desc = "Leave the cave and speak to Lip"
	elif questlevel == 5:
		current_quest_title = "Museum"
		current_quest_desc = "Look for the museum"

func questvis():
	$QuestBox/QuestTitle.set_text(current_quest_title) 
	$QuestBox/QuestDescription.set_text(current_quest_desc)
	

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cave"
		else:
			current_scene = "world"
				

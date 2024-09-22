extends Node

func _physics_process(delta):
	questlevels()
	questvis()



var player_current_attack = false		#attack stuff
var stealth_mode = false

var current_scene = "world"			# scene transitions
var transition_scene = false
var game_first_load = true
var transition_scene_cave = false
var transition_scene_museum = false
var go_to_scene = "cave" 

var player_exit_cave_posx = 376			# in and out cords of cave scene
var player_exit_cave_posy = -49
var player_start_posx = -572
var player_start_posy = -57

var bridge_acces = false			# level progression
var cave_acces = false
var cave_win = false
var sword = false
var cloak = false

var current_wave: int
var moving_to_next_wave: bool

var questlevel = 1
var current_quest_title
var current_quest_desc

func questlevels():
	if questlevel == 1:
		current_quest_title = "LIP:"
		current_quest_desc = "Find Lip and speak with him"
	elif questlevel == 1.1:
		current_quest_title = "SPEAK:"
		current_quest_desc = "Press 'D' to speak with Lip, press 'enter' to advance"
	elif questlevel == 2:
		current_quest_title = "CAVE:"
		current_quest_desc = "Explore the caves in the North"
	elif questlevel == 3:
		current_quest_title = "INKLINGS:"
		current_quest_desc = "Kill all the Inklings"
	elif questlevel == 4:
		current_quest_title = "LIP"
		current_quest_desc = "Leave the cave and speak to Lip"
	elif questlevel == 5:
		current_quest_title = "MUSEUM"
		current_quest_desc = "Look for the museum"

func questvis():
	$QuestBox/QuestTitle.set_text(current_quest_title) 
	$QuestBox/QuestDescription.set_text(current_quest_desc)
	

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world" and go_to_scene == "cave":
			current_scene = "cave"
		elif current_scene != "world":
			current_scene = "world"
				

extends Node

var music = true
var sound = true
var controller = false
var won1 = false
var won2 = false
var cs1 = false

func _physics_process(delta):
	questlevels()
	questvis()
	pause()
	debug()
	if music == true and !$backingmusic.playing:
		$backingmusic.play()
	elif music == false and $backingmusic.playing:
		$backingmusic.stop()
	

func _ready():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

var current_scene = "res://scenes/world.tscn"
var player_health = 100
var player_current_attack = false		#attack stuff
var stealth_mode = false
var able_to_move = true
var deaths = 0
		# scene transitions
var transition_scene = false
var game_first_load = true
var transition_scene_cave = false
var transition_scene_museum = false
var go_to_scene = "res://scenes/cave.tscn"
var museumcp = 0
var bossfight = false

var player_exit_cave_posx = 376			# in and out cords of cave scene
var player_exit_cave_posy = -49
var player_start_posx = -572
var player_start_posy = -57
var player_posx
var player_posy
var cp0_posx
var cp0_posy
var cp1_posx = 117
var cp1_posy = -213
var cp2_posx = 117
var cp2_posy = -340

var bridge_acces = false			# level progression
var cave_acces = false
var cave_win = false
var sword = false
var cloak = false
var paintings = 0
var show_healthbar = false
var acces_door_right = false
var acces_door_left = false



var current_wave: int
var moving_to_next_wave: bool

var questlevel = 1
var current_quest_title
var current_quest_desc
var chatting = false

var hard_difficulty = false		# menu settings
var sound_on = true
var music_on = true
var menu = true

func questlevels():
	if questlevel == 1:
		current_quest_title = "LIP:"
		current_quest_desc = "Find Lip and speak with him"
		if menu == true:
			$QuestBox.visible = false
		else:
			$QuestBox.visible = true
	elif questlevel == 0:
		current_quest_title = " "
		current_quest_desc = " "
	elif questlevel == 1.1:
		current_quest_title = "SPEAK:"
		if Global.controller == false:
			current_quest_desc = "Press 'D' to speak with Lip, press 'enter' to advance"
		if Global.controller == true:
			current_quest_desc = "Press TRIANGLE to speak with Lip, press 'enter' to advance"
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
	elif questlevel == 6:
		current_quest_title = "MUSEUM"
		current_quest_desc = "Kill the Inklinks and secure the art"
	elif questlevel == 7:
		current_quest_title = "KEY"
		current_quest_desc = "Find the keycard to open the door"
	elif questlevel == 8:
		current_quest_title = "KEY"
		if Global.controller == false:
			current_quest_desc = "Press 'D' to pick up the keycard"
		if Global.controller == true:
			current_quest_desc = "Press TRIANGLE to pick up the keycard"
	elif questlevel == 9:
		current_quest_title = "Door"
		if Global.controller == false:
			current_quest_desc = "Press 'D' to swipe the keycard and open the door"
		if Global.controller == true:
			current_quest_desc = "Press TRIANGLE to swipe the keycard and open the door"
	elif questlevel == 10:
		current_quest_title = "Lip"
		current_quest_desc = "Speak with Lip"
	elif questlevel == 11:
		current_quest_title = "Museum"
		current_quest_desc = "Artpieces secured: " + str(paintings) + "/8"
	elif questlevel == 11.1:
		current_quest_title = "Secure"
		if Global.controller == false:
			current_quest_desc = "Press 'W' to secure this artpiece"
		if Global.controller == true:
			current_quest_desc = "Press R1 to secure this artpiece"
	elif questlevel == 12:
		current_quest_title = "Acces"
		current_quest_desc = "Secure all paintings to open the door"
	elif questlevel == 13:
		current_quest_title = "Artifacts"
		current_quest_desc = """Left artifact: x
 
Right artifact: x"""
	elif questlevel == 13.1:
		current_quest_title = "Artifacts"
		if Global.controller == false:
			current_quest_desc = "Press 'W' to secure the artifact"
		if Global.controller == true:
			current_quest_desc = "Press R1 to secure the artifact"
	elif questlevel == 13.2:
		current_quest_title = "Artifacts"
		current_quest_desc = """Left artifact: v
 
Right artifact: x"""
	elif questlevel == 13.3:
		current_quest_title = "Artifacts"
		current_quest_desc = """Left artifact: x
 
Right artifact: v"""
	elif questlevel == 13.4:
		current_quest_title = "Artifacts"
		current_quest_desc = """Left artifact: v
 
Right artifact: v"""
	elif questlevel == 13:
		current_quest_title = "Artifacts"
		current_quest_desc = "Collect both artifacts to open the door"
	elif questlevel == 14:
		current_quest_title = "Keypad"
		if Global.controller == false:
			current_quest_desc = "Press 'D' to use the keypad"
		if Global.controller == true:
			current_quest_desc = "Press TRIANGLE to use the keypad"
	elif questlevel == 15:
		current_quest_title = "Keypad"
		if Global.controller == false:
			current_quest_desc = "ARROW KEYS to enter the code, ENTER to confirm"
		if Global.controller == true:
			current_quest_desc = "Press the D-PAD to enter the code, press X to confirm"
	elif questlevel == 16:
		current_quest_title = "Bossfight"
		if Global.controller == false:
			current_quest_desc = "When both lights are lit press 'D' to open the door"
		if Global.controller == true:
			current_quest_desc = "When both lights are lit press TRIANGLE to open the door"
	elif questlevel == 17:
		current_quest_title = "Switch"
		if Global.controller == false:
			current_quest_desc = "Press 'D' to flip the switch"
		if Global.controller == true:
			current_quest_desc = "Press TRIANGLE to flip the switch"
		
func questvis():
	$QuestBox/QuestTitle.set_text(current_quest_title) 
	$QuestBox/QuestDescription.set_text(current_quest_desc)
	

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "res://scenes/world.tscn" and go_to_scene == "res://scenes/cave.tscn":
			current_scene = "res://scenes/cave.tscn"
		elif current_scene == "res://scenes/world.tscn" and go_to_scene == "res://scenes/museum.tscn":
			current_scene = "res://scenes/cave.tscn"
		elif current_scene != "res://scenes/world.tscn":
			current_scene = "res://scenes/world.tscn"
				

func pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
		menu = true

func debug():
	if Input.is_action_just_pressed("debug1"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		current_scene = "res://scenes/world.tscn"
		questlevel = 1
		sword = false
		cloak = false
	if Input.is_action_just_pressed("debug2"):
		get_tree().change_scene_to_file("res://scenes/cave.tscn")
		current_scene = "res://scenes/cave.tscn"
		questlevel = 3
		sword = true
		cloak = false
	if Input.is_action_just_pressed("debug3"):
		get_tree().change_scene_to_file("res://scenes/museum.tscn")
		current_scene = "res://scenes/museum.tscn"
		questlevel = 6
		sword = true
		cloak = true
		player_health = 100
	

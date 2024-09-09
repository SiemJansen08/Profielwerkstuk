extends Node

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

@onready var questbox: CanvasLayer = Global.get_node("questbox")



func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cave"
		else:
			current_scene = "world"
				

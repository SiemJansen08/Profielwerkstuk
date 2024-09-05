extends Node

var player_current_attack = false
var stealth_mode = false

var current_scene = "world"
var transition_scene = false

var player_exit_cave_posx = 0
var player_exit_cave_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cave"
		else:
			current_scene = "world"
				

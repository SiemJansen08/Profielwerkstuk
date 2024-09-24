extends Node2D

@export var inkling_scene: PackedScene

func _ready():
	if Global.game_first_load == true:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
		$TileMap/bridge_entrance/bridge_entrance_col.set_deferred("disabled", false)
		$TileMap/cave_entrance/cave_entrance/cave_entrance_col.set_deferred("disabled", false)
	else:
		$player.position.x = Global.player_exit_cave_posx
		$player.position.y = Global.player_exit_cave_posy
	

func _process(delta):
	change_scene()
	level_progression()

func _on_cave_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func _on_museum_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
	

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			if Global.go_to_scene == "cave":
				get_tree().change_scene_to_file("res://scenes/cave.tscn")
				Global.game_first_load = false
				Global.questlevel = 3
				Global.finish_changescenes()
			if Global.go_to_scene == "museum":
				get_tree().change_scene_to_file("res://scenes/museum.tscn")
				Global.questlevel = 6
				Global.finish_changescenes()

			
func level_progression():
	if Global.cave_acces == true:
		$TileMap/cave_entrance/cave_entrance/cave_entrance_col.set_deferred("disabled", true)
	if Global.cave_win == true:
		$TileMap/cave_entrance/cave_entrance/cave_entrance_col.set_deferred("disabled", false)
	#if Global.cave_win == true:
		#Global.bridge_acces = true
	
	if Global.bridge_acces == true:
		$TileMap/bridge_entrance/bridge_entrance_col.set_deferred("disabled", true)
		
	

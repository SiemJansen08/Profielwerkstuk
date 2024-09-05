extends Node2D

func _ready():
	if Global.game_first_load == true:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
	else:
		$player.position.x = Global.player_exit_cave_posx
		$player.position.y = Global.player_exit_cave_posy
	

func _process(delta):
	change_scene()



func _on_cave_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true



		
		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/cave.tscn")
			Global.game_first_load = false
			Global.finish_changescenes()
extends Node2D

@export var inkling_scene: PackedScene
var current_wave: int
var starting_nodes: int
var current_nodes: int
var wave_spawn_ended 


func _start():
	pass
	
func _process(delta):
	change_scenes()

func _on_cave_exit_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "cave":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()
			

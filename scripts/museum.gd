extends Node2D

func _ready():
	pass 

func _process(delta):
	change_scenes()

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "museum":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()

func _on_museum_exit_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

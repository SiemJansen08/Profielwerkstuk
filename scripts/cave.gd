extends Node2D

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
			

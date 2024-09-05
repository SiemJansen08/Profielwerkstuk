extends Node2D

func _ready():
	pass
	

func _process(delta):
	change_scene()



func _on_cave_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true


func _on_cave_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		
		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/cave.tscn")
			Global.finish_changescenes()

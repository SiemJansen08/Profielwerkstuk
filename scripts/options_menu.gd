extends Control



func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	


func _on_difficulty_toggled(toggled_on):
	Global.hard_difficulty = true

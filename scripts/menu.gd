extends Control



func _on_play_pressed():
	if Global.player_health < 20:
		Global.player_health = 100
		Global.paintings = 0
		get_tree().change_scene_to_file(Global.current_scene)
		Global.menu = false
	else:
		get_tree().change_scene_to_file(Global.current_scene)
		Global.menu = false
	
func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_story_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()

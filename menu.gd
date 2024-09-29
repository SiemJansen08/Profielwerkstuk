extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	Global.current_scene = "world"
	if Global.game_first_load == true:
		Global.questlevel = 1
	else:
		Global.player_health = 100
	
func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_story_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()

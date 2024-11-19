extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file(Global.current_scene)
	Global.menu = false
	print("Deaths: ", Global.deaths)
	print("Health: ", Global.player_health)
	if Global.game_first_load == true:
		Global.questlevel = 1
	elif Global.player_health == 0:
		Global.player_health = Global.player_health + 100
		Global.deaths = Global.deaths + 1
	
func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_story_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()

extends Control

func _on_play_pressed():
	if Global.sound == true:
		$select.play()
	$wait_play.start()
	
	
func _on_options_pressed():
	if Global.sound == true:
		$select.play()
	$wait_options.start()
	
	

func _on_story_pressed():
	if Global.sound == true:
		$select.play()


func _on_quit_pressed():
	if Global.sound == true:
		$select.play()
	$wait_quit.start()


func _on_wait_timeout():
	if Global.player_health < 20:
		Global.player_health = 100
		Global.paintings = 0
		get_tree().change_scene_to_file(Global.current_scene)
		Global.menu = false
	else:
		get_tree().change_scene_to_file(Global.current_scene)
		Global.menu = false


func _on_wait_options_timeout():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_wait_quit_timeout():
		get_tree().quit()

extends Control



func _on_back_pressed():
	if Global.sound == true:
		$select.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	


func _on_difficulty_toggled(toggled_on):
	if Global.sound == true:
		$select.play()
	Global.hard_difficulty = true

func _on_music_pressed():
	if Global.sound == true:
		$select.play()
	if Global.music == true:
		Global.music = false
	elif Global.music == false:
		Global.music = true


func _on_sound_pressed():
	if Global.sound == true:
		$select.play()
	if Global.sound == true:
		Global.sound = false
	elif Global.sound == false:
		Global.sound = true

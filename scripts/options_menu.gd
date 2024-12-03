extends Control

var able_to_toggle = true

func _ready():
	$RichTextLabel.visible = true
	$RichTextLabel2.visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("button_layout") and Global.controller == false and able_to_toggle == true:
		Global.controller = true
		$RichTextLabel.visible = false
		$RichTextLabel2.visible = true
		able_to_toggle = false
		$toggle_timer.start()
		print("true")
	if Input.is_action_just_pressed("button_layout") and Global.controller == true and able_to_toggle == true:
		Global.controller = false
		$RichTextLabel.visible = true
		$RichTextLabel2.visible = false
		able_to_toggle = false
		$toggle_timer.start()
		print("false")

func _on_back_pressed():
	if Global.sound == true:
		$select.play()
	$wait_back.start()

	


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


func _on_wait_back_timeout():
		get_tree().change_scene_to_file("res://scenes/menu.tscn")




func _on_toggle_timer_timeout():
	able_to_toggle = true

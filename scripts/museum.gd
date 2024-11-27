extends Node2D

var ready_play = false
var key_door_1 = false
var player_pickup = false
var acces_door_1 = false
var acces_door_2 = false
var acces_door_3 = false

@onready var healthbar = $player/Healthbar

func _ready():
	Global.current_scene = "res://scenes/museum.tscn"
	$start_timer.start()
	Global.questlevel = 6
	
	$TileMap/hekje_1/door_1/door_1_col.set_deferred("disabled", false)
	healthbar.init_health(Global.player_health)
	#Global.player_health = Global.player_health + 20
	print(Global.player_health)
	Global.questlevel = 6
	$TileMap/keycard1/AnimationPlayer.play("keycard")
	$paintings/gouden_kikker/AnimationPlayer.play("new_animation")
	$paintings/blauwe_kikker/AnimationPlayer.play("new_animation")

func _process(delta):
	change_scenes()
	if Input.is_action_just_pressed("chat") and player_pickup:
		key_door_1 = true
		if Global.sound == true:
			$grab.play()
		$TileMap/keycard1.queue_free()
		player_pickup = false
		Global.questlevel = 7
	if Input.is_action_just_pressed("chat") and acces_door_1 == true:
			$TileMap/hekje_1/AnimationPlayer.play("new_animation")
			if Global.sound == true:
				$schuifdeur.play()
			$TileMap/hekje_1/Timer.start()
			acces_door_1 = false
			Global.questlevel = 10
	if Input.is_action_just_pressed("chat") and acces_door_2 == true:
			$TileMap/hekje_2/AnimationPlayer.play("new_animation")
			if Global.sound == true:
				$schuifdeur.play()
			$TileMap/hekje_2/Timer_door_2.start()
			acces_door_2 = false
	if Input.is_action_just_pressed("chat") and acces_door_3 == true:
			$TileMap/hekje_3/AnimationPlayer.play("new_animation")
			if Global.sound == true:
				$schuifdeur.play()
			$TileMap/hekje_3/Timer_door_3.start()
			acces_door_3 = false
			
func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "res://scenes/museum.tscn":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()

func _on_museum_exit_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		change_scenes()

func _on_acces_door_1_body_entered(body):
	if ready_play:
		if key_door_1 == true:
			Global.questlevel = 9
			acces_door_1 = true
		elif key_door_1 == false:
			Global.questlevel = 7
func _on_hekje_2_acces_door_body_entered(body):
	if ready_play:
		if Global.acces_door_left == true and Global.acces_door_right == true:
			acces_door_2 = true

func _on_acces_door_3_body_entered(body):
	if ready_play:
		if Global.paintings == 8:
			Global.questlevel = 9
			acces_door_3 = true
		elif Global.paintings < 8:
			Global.questlevel = 12

func _on_acces_door_3_body_exited(body):
	if Global.paintings < 8:
		Global.questlevel = 11

func _on_lasers_body_entered(body):
	if ready_play:
		Global.player_health = Global.player_health - 20
		if Global.sound == true:
			$laserhit.play()
		healthbar.health = Global.player_health
		print(Global.player_health)

func _on_keycardpickup_1_body_entered(body):
	if ready_play:
		Global.questlevel = 8
		player_pickup = true

func _on_timer_timeout():
	$TileMap/hekje_1/door_1/door_1_col.set_deferred("disabled", true)
	$TileMap/hekje_1/AnimationPlayer.pause()

func _on_timer_door_2_timeout():
	$TileMap/hekje_2/door_1/door_1_col.set_deferred("disabled", true)
	$TileMap/hekje_2/AnimationPlayer.pause()
	Global.show_healthbar = true

func _on_timer_door_3_timeout():
	$TileMap/hekje_3/door_1/door_1_col.set_deferred("disabled", true)
	$TileMap/hekje_3/AnimationPlayer.pause()





func _on_start_timer_timeout():
	ready_play = true


func _on_painting_1_grab():
	if Global.sound == true:
		$grab.play()


func _on_painting_2_grab():
	if Global.sound == true:
		$grab.play()


func _on_painting_3_grab():
	if Global.sound == true:
		$grab.play()


func _on_painting_4_grab():
	if Global.sound == true:
		$grab.play()


func _on_painting_5_grab():
	if Global.sound == true:
		$grab.play()


func _on_painting_6_grab():
	if Global.sound == true:
		$grab.play()


func _on_painting_7_grab():
	if Global.sound == true:
		$grab.play()


func _on_painting_8_grab():
	if Global.sound == true:
		$grab.play()

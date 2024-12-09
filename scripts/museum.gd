extends Node2D

var ready_play = false
var key_door_1 = false
var player_pickup = false
var acces_door_1 = false
var acces_door_2 = false
var acces_door_3 = false
var laser_puzzle_opgelost = false
var keypad_toegang = false
var keypad_voortgang = 0
var keypad_invoer = 0
var invoer_mogelijk = true
var knop_toegang = false
var checkpoint = 0

var boss_inkling = preload("res://scenes/cave_inkling.tscn")
var starting_nodes: int
var current_nodes: int

var camera_1_in_zicht = false
var camera_2_in_zicht = false
var camera_3_in_zicht = false
var camera_4_in_zicht = false
var camera_5_in_zicht = false

var laser_1_aan = false
var laser_2_aan = false
var laser_3_aan = false
var laser_4_1_aan = false
var laser_4_2_aan = false
var laser_lampje_dubbel = false

@onready var healthbar = $player/Healthbar

func _ready():
	Global.current_scene = "res://scenes/museum.tscn"
	$victory.hide()
	$start_timer.start()
	Global.questlevel = 6
	
	$TileMap/hekje_1/door_1/door_1_col.set_deferred("disabled", false)
	healthbar.init_health(Global.player_health)
	print(Global.player_health)
	Global.questlevel = 6
	$TileMap/keycard1/AnimationPlayer.play("keycard")
	$paintings/gouden_kikker/AnimationPlayer.play("new_animation")
	$paintings/blauwe_kikker/AnimationPlayer.play("new_animation")
	
	$lampen/PointLight2D.visible = false
	$lampen/PointLight2D2.visible = false
	
	$keypad_puzzle/keypad_puzzle_groot.visible = false
	$keypad_puzzle/laser_uit.visible = false
	
	$level_rechts/laser_1_aan.visible = false
	$level_rechts/laser_2_aan.visible = false
	$level_rechts/laser_2_aan2.visible = false
	$level_rechts/laser_3_aan.visible = true
	$level_rechts/laser_4_aan.visible = false
	$level_rechts/laser_4_aan2.visible = false
	$level_rechts/laser_3_lampje.set_frame(1)

	if Global.museumcp == 1:
		$player.position.x = Global.cp1_posx
		$player.position.y = Global.cp1_posy
	elif Global.museumcp == 2:
		$player.position.x = Global.cp2_posx
		$player.position.y = Global.cp2_posy
		
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	

func _process(delta):
	change_scenes()
	_laser_process(delta)
	_laser_visible(delta)
	if Global.won1 == true and Global.won2 == true:
		$victory.show()
		$victory/victorycam.enabled = true
		
	
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
			Global.museumcp = 2
			Global.bossfight = true
			Global.cloak = false
			acces_door_2 = false
	if Input.is_action_just_pressed("chat") and acces_door_3 == true:
			$TileMap/hekje_3/AnimationPlayer.play("new_animation")
			if Global.sound == true:
				$schuifdeur.play()
			$TileMap/hekje_3/Timer_door_3.start()
			Global.museumcp = 1
			acces_door_3 = false
			Global.questlevel = 13
	if Global.acces_door_left == true:
		$lampen/PointLight2D2.visible = true
	if Global.acces_door_right == true:
		$lampen/PointLight2D.visible = true
	if keypad_toegang == true:
		if Input.is_action_just_pressed("chat"):
			$keypad_puzzle/keypad_puzzle_groot.visible = true
			Global.questlevel = 15
			keypad_voortgang = 0
			keypad_invoer = 0
			Global.able_to_move = false
		if Input.is_action_just_pressed("ui_accept"):
			Global.able_to_move = true
			$keypad_puzzle/keypad_puzzle_groot.visible = false
			if Global.acces_door_left == true and Global.acces_door_right == false:
				Global.questlevel = 13.2
			elif Global.acces_door_left == false and Global.acces_door_right == true:
				Global.questlevel = 13.3
			elif Global.acces_door_left == false and Global.acces_door_right == false:
				Global.questlevel = 13
			elif Global.acces_door_left == true and Global.acces_door_right == true:
				Global.questlevel = 13.4
	
	if keypad_invoer == 4:
				laser_puzzle_opgelost = true
	
	if keypad_toegang == false:
		$keypad_puzzle/keypad_puzzle_groot.visible = false
		
	if knop_toegang == true:
		if Input.is_action_just_pressed("chat"):
			$level_rechts/laser_3_lampje.set_frame(0)
			$level_rechts/laser_3_aan.visible = false
	
	if laser_puzzle_opgelost == true:
		$keypad_puzzle/keypad_puzzle_groot.set_frame(8)
	if laser_puzzle_opgelost == false:
		$keypad_puzzle/keypad_puzzle_groot.set_frame(keypad_voortgang)
	
	if laser_puzzle_opgelost == true:
		$keypad_puzzle/laser_aan.visible = false
		$keypad_puzzle/laser_uit.visible = true
	
	if $keypad_puzzle/keypad_puzzle_groot.visible == true:
		if keypad_voortgang == 0 and invoer_mogelijk == true and laser_puzzle_opgelost == false:
			if Input.is_action_just_pressed("ui_up"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_down"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
				keypad_invoer = keypad_invoer + 1
				print(keypad_voortgang)
				print(keypad_invoer)
			if Input.is_action_just_pressed("ui_left"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_right"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
		if keypad_voortgang == 2 and invoer_mogelijk == true:
			if Input.is_action_just_pressed("ui_up"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
				keypad_invoer = keypad_invoer + 1
				print("ja")
				print(keypad_invoer)
			if Input.is_action_just_pressed("ui_down"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_left"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_right"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
		if keypad_voortgang == 4 and invoer_mogelijk == true:
			if Input.is_action_just_pressed("ui_up"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_down"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_left"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
				keypad_invoer = keypad_invoer + 1
				print("ja")
				print(keypad_invoer)
			if Input.is_action_just_pressed("ui_right"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
		if keypad_voortgang == 6 and invoer_mogelijk == true:
			if Input.is_action_just_pressed("ui_up"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_down"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
				keypad_invoer = keypad_invoer + 1
				print("ja")
				print(keypad_invoer)
			if Input.is_action_just_pressed("ui_left"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
			if Input.is_action_just_pressed("ui_right"):
				keypad_voortgang = keypad_voortgang + 1
				$keypad_puzzle/invoer_timer.start()
				invoer_mogelijk = false
	
	current_nodes = get_child_count()
	if current_nodes == starting_nodes and Global.won1 == true:
		Global.won2 = true
		print("won2")
	
	
	
	
	
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
		if Global.acces_door_left == true and Global.acces_door_right == true :
			Global.questlevel = 9
			acces_door_2 = true
		elif Global.questlevel == 13 or Global.questlevel == 13.1 or Global.questlevel == 13.2 or Global.questlevel == 13.3:
			Global.questlevel = 16

func _on_hekje_2_acces_door_body_exited(body):
	if Global.acces_door_left == true and Global.acces_door_right == false:
		Global.questlevel = 13.2
	elif Global.acces_door_left == false and Global.acces_door_right == true:
		Global.questlevel = 13.3
	elif Global.acces_door_left == false and Global.acces_door_right == false:
		Global.questlevel = 13
	elif Global.acces_door_left == true and Global.acces_door_right == true:
		Global.questlevel = 13.4

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
		
func _on_laser_level_links_1_body_entered(body):
	if ready_play and laser_puzzle_opgelost == false:
		Global.player_health = Global.player_health - 20
		if Global.sound == true:
			$laserhit.play()
		healthbar.health = Global.player_health
		print(Global.player_health)
func _on_laser_level_links_2_body_entered(body):
	if ready_play and laser_puzzle_opgelost == false:
		Global.player_health = Global.player_health - 20
		if Global.sound == true:
			$laserhit.play()
		healthbar.health = Global.player_health
		print(Global.player_health)
func _on_laser_level_links_3_body_entered(body):
	if ready_play and laser_puzzle_opgelost == false:
		Global.player_health = Global.player_health - 20
		if Global.sound == true:
			$laserhit.play()
		healthbar.health = Global.player_health
		print(Global.player_health)

func _on_lasers_level_rechts_body_entered(body):
	if ready_play:
		if $level_rechts/laser_1_aan.visible == true or $level_rechts/laser_2_aan.visible == true or $level_rechts/laser_2_aan2.visible == true or $level_rechts/laser_4_aan.visible == true or $level_rechts/laser_4_aan2.visible == true:
			Global.player_health = Global.player_health - 20
			if Global.sound == true:
				$laserhit.play()
			healthbar.health = Global.player_health
			print(Global.player_health)

func _on_laser_blauwe_kikker_body_entered(body):
	if ready_play:
		if $level_rechts/laser_3_aan.visible == true:
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

func _on_keypad_toegang_collision_body_entered(body):
	if ready_play:
		keypad_toegang = true
		Global.questlevel = 14
	
	
func _on_keypad_toegang_collision_body_exited(body):
	if ready_play:
		keypad_toegang = false
		$keypad_puzzle/keypad_puzzle_groot.visible = false
		if Global.acces_door_left == true and Global.acces_door_right == false:
			Global.questlevel = 13.2
		elif Global.acces_door_left == false and Global.acces_door_right == true:
			Global.questlevel = 13.3
		elif Global.acces_door_left == false and Global.acces_door_right == false:
			Global.questlevel = 13
		elif Global.acces_door_left == true and Global.acces_door_right == true:
			Global.questlevel = 13.4







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



func _on_invoer_timer_timeout():
	invoer_mogelijk = true
	if keypad_voortgang < 6:
		keypad_voortgang = keypad_voortgang + 1
	if keypad_voortgang == 7 and keypad_invoer == 4:
		keypad_voortgang = 8
	print("klaar")


func _on_quit_pressed():
	if Global.sound == true:
		$victory/select.play()
	$victory/wait_quit.start()


func _on_wait_quit_timeout():
	get_tree().quit()


func _on_camera_area_1_body_entered(body):
	if ready_play:
		camera_1_in_zicht = true

func _on_camera_area_1_body_exited(body):
	if ready_play:
		camera_1_in_zicht = false
		
func _on_camera_area_2_body_entered(body):
	if ready_play:
		camera_2_in_zicht = true

func _on_camera_area_2_body_exited(body):
	if ready_play:
		camera_2_in_zicht = false

func _on_camera_area_3_body_entered(body):
	if ready_play:
		camera_3_in_zicht = true

func _on_camera_area_3_body_exited(body):
	if ready_play:
		camera_3_in_zicht = false

func _on_camera_area_4_body_entered(body):
	if ready_play:
		camera_4_in_zicht = true

func _on_camera_area_4_body_exited(body):
	if ready_play:
		camera_4_in_zicht = false

func _on_camera_area_5_body_entered(body):
	if ready_play:
		camera_5_in_zicht = true

func _on_camera_area_5_body_exited(body):
	if ready_play:
		camera_5_in_zicht = false

func _laser_process(delta):
	if camera_1_in_zicht == true and Global.stealth_mode == true:
		if laser_1_aan == true:
			laser_deactivate()
			laser_1_aan = false
	if camera_1_in_zicht == true and Global.stealth_mode == false:
		laser_1_aan = true
		$level_rechts/laser_1_aan.visible = true
		$level_rechts/AnimationPlayer.play("laser_1_lampje_knipperen")
	if camera_1_in_zicht == false and Global.stealth_mode == true:
		if laser_1_aan == true:
			laser_deactivate()
			laser_1_aan = false
	if camera_1_in_zicht == false and Global.stealth_mode == false:
		if laser_1_aan == true:
			laser_deactivate()
			laser_1_aan = false
	
	if camera_2_in_zicht == true and Global.stealth_mode == true:
		if laser_1_aan == true:
			laser_deactivate()
			laser_1_aan = false
	if camera_2_in_zicht == true and Global.stealth_mode == false:
		laser_1_aan = true
		$level_rechts/AnimationPlayer.play("laser_1_lampje_knipperen")
	if camera_2_in_zicht == false and Global.stealth_mode == true:
		if laser_1_aan == true:
			laser_deactivate()
			laser_1_aan = false
	if camera_2_in_zicht == false and Global.stealth_mode == false:
		if laser_1_aan == true:
			laser_deactivate()
			laser_1_aan = false
	
	if camera_3_in_zicht == true and Global.stealth_mode == true:
		if laser_2_aan == true:
			laser_deactivate()
			laser_2_aan = false
	if camera_3_in_zicht == true and Global.stealth_mode == false:
		laser_2_aan = true
		$level_rechts/AnimationPlayer.play("laser_2_lampje_knipperen")
	if camera_3_in_zicht == false and Global.stealth_mode == true:
		if laser_2_aan == true:
			laser_deactivate()
			laser_2_aan = false
	if camera_3_in_zicht == false and Global.stealth_mode == false:
		if laser_2_aan == true:
			laser_deactivate()
			laser_2_aan = false
	
	if camera_4_in_zicht == true and Global.stealth_mode == true:
		if laser_4_1_aan == true:
			laser_deactivate()
			laser_4_1_aan = false
	if camera_4_in_zicht == true and Global.stealth_mode == false:
		laser_4_1_aan = true
		if laser_4_2_aan == true:
			laser_lampje_dubbel = true
		if laser_lampje_dubbel == false:
			$level_rechts/AnimationPlayer.play("laser_4_lampje_knipperen")
		if laser_lampje_dubbel == true:
			$level_rechts/AnimationPlayer.play("laser_4_allebei_knipperen")
	if camera_4_in_zicht == false and Global.stealth_mode == true:
		if laser_4_1_aan == true:
			laser_deactivate()
			laser_4_1_aan = false
	if camera_4_in_zicht == false and Global.stealth_mode == false:
		if laser_4_1_aan == true:
			laser_deactivate()
			laser_4_1_aan = false

	if camera_5_in_zicht == true and Global.stealth_mode == true:
		if laser_4_2_aan == true:
			laser_deactivate()
			laser_4_2_aan = false
	if camera_5_in_zicht == true and Global.stealth_mode == false:
		laser_4_2_aan = true
		if laser_4_1_aan == true:
			laser_lampje_dubbel = true
		if laser_lampje_dubbel == false:
			$level_rechts/AnimationPlayer.play("laser_4_2_lampje_knipperen")
		if laser_lampje_dubbel == true:
			$level_rechts/AnimationPlayer.play("laser_4_allebei_knipperen")
	if camera_5_in_zicht == false and Global.stealth_mode == true:
		if laser_4_2_aan == true:
			laser_deactivate()
			laser_4_2_aan = false
	if camera_5_in_zicht == false and Global.stealth_mode == false:
		if laser_4_2_aan == true:
			laser_deactivate()
			laser_4_2_aan = false


func _laser_visible(delta):
		if laser_1_aan == true:
			$level_rechts/laser_1_aan.visible = true
		if laser_2_aan == true:
			$level_rechts/laser_2_aan.visible = true
			$level_rechts/laser_2_aan2.visible = true
		if laser_4_1_aan == true:
			$level_rechts/laser_4_aan.visible = true
		if laser_4_2_aan == true:
			$level_rechts/laser_4_aan2.visible = true


func laser_deactivate():
	$level_rechts/laser_deactivate.start()

func _on_laser_deactivate_timeout():
	$level_rechts/laser_1_aan.visible = false
	$level_rechts/laser_2_aan.visible = false
	$level_rechts/laser_2_aan2.visible = false
	$level_rechts/laser_4_aan.visible = false
	$level_rechts/laser_4_aan2.visible = false
	laser_lampje_dubbel = false
	$level_rechts/AnimationPlayer.stop()
	$level_rechts/laser_1_lampje.set_frame(0)
	$level_rechts/laser_2_lampje.set_frame(0)
	$level_rechts/laser_2_lampje2.set_frame(0)
	$level_rechts/laser_4_lampje.set_frame(0)
	$level_rechts/laser_4_lampje2.set_frame(0)



func _on_knop_toegang_body_entered(body):
	if ready_play:
		knop_toegang = true
		Global.questlevel = 17

func _on_knop_toegang_body_exited(body):
	if ready_play:
		knop_toegang = false
		if Global.acces_door_left == true and Global.acces_door_right == false:
			Global.questlevel = 13.2
		elif Global.acces_door_left == false and Global.acces_door_right == true:
			Global.questlevel = 13.3
		elif Global.acces_door_left == false and Global.acces_door_right == false:
			Global.questlevel = 13
		elif Global.acces_door_left == true and Global.acces_door_right == true:
			Global.questlevel = 13.4


func inst(pos):
	var instance = boss_inkling.instantiate()
	instance.position = pos
	add_child(instance)


func _on_eindbaas_wave_1():
	$gong.play()
	inst(Vector2(39, -381))
	inst(Vector2(39, -515))
	inst(Vector2(300, -538))
	inst(Vector2(151, -468))
	inst(Vector2(126, -600))
	inst(Vector2(119, -386))


func _on_eindbaas_wave_2():
	$gong.play()
	inst(Vector2(39, -381))
	inst(Vector2(39, -515))
	inst(Vector2(300, -538))
	inst(Vector2(151, -468))
	inst(Vector2(126, -600))
	inst(Vector2(119, -386))
	await get_tree().create_timer(3).timeout
	inst(Vector2(39, -381))
	inst(Vector2(39, -515))
	inst(Vector2(300, -538))
	inst(Vector2(151, -468))
	inst(Vector2(126, -600))
	inst(Vector2(119, -386))

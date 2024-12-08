extends CharacterBody2D

const speed = 70
const speed_stealth = 90
var current_dir = "none"
var enemy_inattack_range = false
var enemy_attack_cooldown = true
#var health = 100
@onready var healthbar = $Healthbar
@onready var lip_camera = $npc1/lip_camera
var player_alive = true
var attack_ip = false

func _ready():
	$AnimatedSprite2D.play("front_idle")
	healthbar.init_health(Global.player_health)

func _physics_process(delta):
	attack(delta)
	input_direction(delta)
	enemy_attack()
	stealth()
	current_camera()
	
	
	if Global.player_health <= 0:
		player_alive = false # terug naar menu of end screen.
		Global.player_health = 0
		print("player has died")
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
	'''if health == 100:			#healthbar verdwijnt bij 100 hp
		$Healthbar.hide()
	else:
		$Healthbar.show()'''

func input_direction(delta):
	var side_movement = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var vertical_movement = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	if Global.able_to_move == true:
		if side_movement == -1:
			current_dir = "left"
			play_anim(1)
			if Global.stealth_mode == true and Global.cloak == true:
				velocity.x = -speed_stealth
				velocity.y = 0
			else:
				velocity.x = -speed
				velocity.y = 0
		elif side_movement == 1:
			current_dir = "right"
			play_anim(1)
			if Global.stealth_mode == true and Global.cloak == true:
				velocity.x = speed_stealth
				velocity.y = 0
			else:
				velocity.x = speed
				velocity.y = 0
		elif vertical_movement == -1:
			current_dir = "up"
			play_anim(1)
			if Global.stealth_mode == true and Global.cloak == true:
				velocity.y = -speed_stealth
				velocity.x = 0
			else:
				velocity.y = -speed
				velocity.x = 0
		elif vertical_movement == 1:
			current_dir = "down"
			play_anim(1)
			if Global.stealth_mode == true and Global.cloak == true:
				velocity.y = speed_stealth
				velocity.x = 0
			else:
				velocity.y = speed
				velocity.x = 0
		else:
			play_anim(0)
			velocity.x = 0
			velocity.y = 0
		
		if attack_ip == false:
			move_and_slide()
		
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if attack_ip == false:
		if dir == "right":
			if movement == 1:
				if Global.stealth_mode == false:
					anim.play("right_walk")
					if !$footsteps.playing and Global.current_scene == "res://scenes/world.tscn" and Global.sound == true:
						$footsteps.play()
					elif !$footstepcave.playing and Global.current_scene == "res://scenes/cave.tscn" and Global.sound == true or !$footstepcave.playing and Global.current_scene == "res://scenes/museum.tscn" and Global.sound == true:
						$footstepcave.play()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("right_walk_stealth")
			elif movement == 0:
				if attack_ip == false and Global.stealth_mode == false:
					anim.play("right_idle")
					if $footsteps.playing:
						$footsteps.stop()
					elif $footstepcave.playing:
						$footstepcave.stop()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("right_idle_stealth")
		
		if dir == "left":
			if movement == 1:
				if Global.stealth_mode == false:
					anim.play("left_walk")
					if !$footsteps.playing and Global.current_scene == "res://scenes/world.tscn" and Global.sound == true:
						$footsteps.play()
					elif !$footstepcave.playing and Global.current_scene == "res://scenes/cave.tscn" and Global.sound == true or !$footstepcave.playing and Global.current_scene == "res://scenes/museum.tscn" and Global.sound == true:
						$footstepcave.play()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("left_walk_stealth")
			elif movement == 0:
				if attack_ip == false and Global.stealth_mode == false:
					anim.play("left_idle")
					if $footsteps.playing:
						$footsteps.stop()
					elif $footstepcave.playing:
						$footstepcave.stop()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("left_idle_stealth")
		
		if dir == "down":
			if movement == 1:
				if Global.stealth_mode == false:
					anim.play("front_walk")
					if !$footsteps.playing and Global.current_scene == "res://scenes/world.tscn" and Global.sound == true:
						$footsteps.play()
					elif !$footstepcave.playing and Global.current_scene == "res://scenes/cave.tscn" and Global.sound == true or !$footstepcave.playing and Global.current_scene == "res://scenes/museum.tscn" and Global.sound == true:
						$footstepcave.play()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("front_walk_stealth")
			elif movement == 0:
				if attack_ip == false and Global.stealth_mode == false:
					anim.play("front_idle")
					if $footsteps.playing:
						$footsteps.stop()
					elif $footstepcave.playing:
						$footstepcave.stop()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("front_idle_stealth")
				
		if dir == "up":
			if movement == 1:
				if Global.stealth_mode == false:
					anim.play("back_walk")
					if !$footsteps.playing and Global.current_scene == "res://scenes/world.tscn" and Global.sound == true:
						$footsteps.play()
					elif !$footstepcave.playing and Global.current_scene == "res://scenes/cave.tscn" and Global.sound == true or !$footstepcave.playing and Global.current_scene == "res://scenes/museum.tscn" and Global.sound == true:
						$footstepcave.play()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("back_walk_stealth")
			elif movement == 0:
				if attack_ip == false and Global.stealth_mode == false:
					anim.play("back_idle")
					if $footsteps.playing:
						$footsteps.stop()
					elif $footstepcave.playing:
						$footstepcave.stop()
				if Global.stealth_mode == true and Global.cloak == true:
					anim.play("back_idle_stealth")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		Global.player_health = Global.player_health - 5
		healthbar.health = Global.player_health
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(Global.player_health)
	elif enemy_inattack_range and enemy_attack_cooldown == true and Global.hard_difficulty == true:
		Global.player_health = Global.player_health - 8
		healthbar.health = Global.player_health
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(Global.player_health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack(delta):
	var dir = current_dir
	if Global.sword == true and Global.stealth_mode == false:
		if Input.is_action_just_pressed("attack"):
			Global.player_current_attack = true
			attack_ip = true
			if dir == "right":
				$AnimatedSprite2D.play("right_attack")
				$deal_attack_timer.start()
				if Global.sound == true:
					$swordhit.play()
			if dir == "left":
				$AnimatedSprite2D.play("left_attack")
				$deal_attack_timer.start()
				if Global.sound == true:
					$swordhit.play()
			if dir == "down":
				$AnimatedSprite2D.play("front_attack")
				$deal_attack_timer.start()
				if Global.sound == true:
					$swordhit.play()
			if dir == "up":
				$AnimatedSprite2D.play("back_attack")
				$deal_attack_timer.start()
				if Global.sound == true:
					$swordhit.play()
			
			

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false

func stealth():
	if Global.cloak == true:
		var dir = current_dir
		var anim = $AnimatedSprite2D
		if Input.is_action_just_pressed("stealth"):
			Global.stealth_mode= true
			if Global.sound == true:
				$stealthsound.play()
			$stealth_time.start()
		
		


func _on_stealth_time_timeout():
	Global.stealth_mode = false
	if Global.sound == true:
		$stealthsound.play()
	$stealth_time.stop()
	
	
func current_camera():
	if Global.current_scene == "res://scenes/world.tscn":
		if Global.chatting == true:
			$world_camera.enabled = false
			$cave_camera.enabled = false
			$museum_camera.enabled = false
			
		$world_camera.enabled = true
		$cave_camera.enabled = false
		$museum_camera.enabled = false
		
	elif Global.current_scene == "res://scenes/cave.tscn":
		$world_camera.enabled = false
		$cave_camera.enabled = true
		$museum_camera.enabled = false
	elif Global.current_scene == "res://scenes/museum.tscn":
		if Global.chatting == true:
			$world_camera.enabled = false
			$cave_camera.enabled = false
			$museum_camera.enabled = false
		
		$world_camera.enabled = false
		$cave_camera.enabled = false
		$museum_camera.enabled = true
		
		if Global.won == true:
			$world_camera.enabled = false
			$cave_camera.enabled = false
			$museum_camera.enabled = false
			
		
		
		

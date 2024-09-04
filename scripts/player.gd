extends CharacterBody2D

const speed = 70
var current_dir = "none"
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false


func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false # terug naar menu of end screen.
		health = 0
		print("player has died")
		self.queue_free()

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			if Global.stealth_mode == false:
				anim.play("right_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("right_idle")
	
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			if Global.stealth_mode == false:
				anim.play("left_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("left_idle")
	
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			if Global.stealth_mode == false:
				anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			if Global.stealth_mode == false:
				anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")
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
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.play("right_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.play("left_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			
			
	
func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
	

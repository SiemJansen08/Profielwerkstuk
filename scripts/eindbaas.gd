extends CharacterBody2D

signal chase
signal wave1
signal wave2

@export var speed = 35 #hoger is langzamer
var player_chase = false
var player = null
var nochase = false

var health = 99
var player_inattack_range = false
var can_take_damage = true

@onready var healthbar = $CanvasLayer/Healthbar

var randomizer = RandomNumberGenerator.new()
var knockback_state = false
var knockback_direction = 1
var knockback_speed = 2

var grootte = 2

func _ready():
	healthbar.init_health(health)
	healthbar.visible = false

func _physics_process(delta):
	deal_with_damage()
	
	if Global.show_healthbar == true:
		healthbar.visible = true
	
	if knockback_state == false:
		if player_chase:
			velocity = (player.get_global_position() - position).normalized() * speed * delta
			
			if(player.position.x - position.x) < 0:
				if grootte == 2:
					$AnimatedSprite2D.play("l_l")
				elif grootte == 1:
					$AnimatedSprite2D.play("m_l")
				elif grootte == 0:
					$AnimatedSprite2D.play("s_l")	
			else:
				if grootte == 2:
					$AnimatedSprite2D.play("l_r")
				elif grootte == 1:
					$AnimatedSprite2D.play("m_r")
				elif grootte == 0:
					$AnimatedSprite2D.play("s_r")	
		
		else:
			velocity = lerp(velocity, Vector2.ZERO, 0.05)
			if grootte == 2:
				$AnimatedSprite2D.play("l_l")
			elif grootte == 1:
				$AnimatedSprite2D.play("m_l")
			elif grootte == 0:
				$AnimatedSprite2D.play("s_l")
	move_and_collide(velocity)
	if knockback_state == true:
		if knockback_direction == 1:
			velocity.x = -knockback_speed
			velocity.y = knockback_speed
		elif knockback_direction == 2:
			velocity.x = -knockback_speed
			velocity.y = -knockback_speed
		elif knockback_direction == 3:
			velocity.x = knockback_speed
			velocity.y = knockback_speed
		elif knockback_direction == 4:
			velocity.x = knockback_speed
			velocity.y = -knockback_speed
	move_and_slide()

	
func _on_detection_area_body_entered(body): 
	if Global.current_scene == "res://scenes/cave.tscn":
		player = body
		player_chase = true
	else:
		player = body
		nochase = false
		emit_signal("chase")

func _on_detection_area_body_exited(body):
		player_chase = false
		nochase = true
		
func enemy():
	pass


func _on_enemy_hitbox_l_body_entered(body):
	if grootte == 2:
		if body.has_method("player"):
			player_inattack_range = true

func _on_enemy_hitbox_l_body_exited(body):
	if grootte == 2:
		if body.has_method("player"):
			player_inattack_range = false
		
func _on_enemy_hitbox_m_body_entered(body):
	if grootte == 1:
		if body.has_method("player"):
			player_inattack_range = true

func _on_enemy_hitbox_m_body_exited(body):
	if grootte == 1:
		if body.has_method("player"):
			player_inattack_range = false
		
func _on_enemy_hitbox_s_body_entered(body):
	if grootte == 0:
		if body.has_method("player"):
			player_inattack_range = true

func _on_enemy_hitbox_s_body_exited(body):
	if grootte == 0:
		if body.has_method("player"):
			player_inattack_range = false
		
func deal_with_damage():
	if player_inattack_range and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			healthbar.health = health
			$knockback.start()
			knockback_state = true
			if grootte == 2:
				$AnimatedSprite2D.play("l_d")
			elif grootte == 1:
				$AnimatedSprite2D.play("m_d")
			elif grootte == 0:
				$AnimatedSprite2D.play("s_d")
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime", health)
			if health <= 0:
				grootte = grootte - 1
				if grootte == 1:
					$large.queue_free()
					emit_signal("wave1")
				if grootte == 0:
					$medium.queue_free()
					emit_signal("wave2")
				player_inattack_range = false
				speed = speed + 10
				knockback_speed = knockback_speed + 0.75 
				health = 99
				healthbar.queue_redraw()
				healthbar.health = health
				if grootte < 0:
					self.queue_free()
					Global.won1 = true
					print("won1")
		



func _on_take_damage_cooldown_timeout():
	can_take_damage = true


func _on_knockback_timeout():
	knockback_direction = randomizer.randi_range(0,3)
	knockback_state = false
	$knockback.stop()


func _on_chase():
	if nochase == false:
		player_chase = true
		if Global.stealth_mode == true:
			player_chase = false
		$stealth_check.start()



func _on_stealth_check_timeout():
	emit_signal("chase")

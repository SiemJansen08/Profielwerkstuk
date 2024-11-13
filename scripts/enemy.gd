extends CharacterBody2D

signal chase

@export var speed = 25 #hoger is langzamer
var player_chase = false
var player = null
var nochase = false

var health = 99
var player_inattack_range = false
var can_take_damage = true

@onready var healthbar = $Healthbar

var randomizer = RandomNumberGenerator.new()
var knockback_state = false
var knockback_direction = 1
var knockback_speed = 3

func _ready():
	healthbar.init_health(health)

func _physics_process(delta):
	deal_with_damage()
	if knockback_state == false:
		if player_chase:
			velocity = (player.get_global_position() - position).normalized() * speed * delta
			
			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.play("left_walk")
			else:
				$AnimatedSprite2D.play("right_walk")
		
		else:
			velocity = lerp(velocity, Vector2.ZERO, 0.05)
			$AnimatedSprite2D.play("idle")
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
	if Global.current_scene == "museum":
		player = body
		nochase = false
		emit_signal("chase")
	if Global.current_scene == "cave":
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if Global.current_scene == "musuem":
		player_chase = false
		nochase = true
	if Global.current_scene == "cave":
		player_chase = false
		player = null
		
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_range = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_range = false
		
func deal_with_damage():
	if player_inattack_range and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 33
			healthbar.health = health
			$knockback.start()
			knockback_state = true
			$AnimatedSprite2D.play("damage")
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime", health)
			if health <= 0:
				self.queue_free()
		



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




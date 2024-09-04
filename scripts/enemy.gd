extends CharacterBody2D

@export var speed = 30 #hoger is langzamer
var player_chase = false
var player = null

var health = 100
var player_inattack_range = false
var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()

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
	move_and_slide()

	
func _on_detection_area_body_entered(body):
		player = body
		if Global.stealth_mode == true:
			player_chase = false
		else:
			player_chase = true
	
func _on_detection_area_body_exited(body):
		player = null
		player_chase = false

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
			health = health - 25
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime", health)
			if health <= 0:
				self.queue_free()
		
	
func _on_take_damage_cooldown_timeout():
	can_take_damage = true

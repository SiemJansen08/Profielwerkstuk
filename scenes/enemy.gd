extends CharacterBody2D

@export var speed = 30 #hoger is langzamer
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase: 
		velocity = (player.get_global_position() - position).normalized() * speed * delta
	
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.05)
		$AnimatedSprite2D.play("idle")
	move_and_collide(velocity)
	move_and_slide()
		

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

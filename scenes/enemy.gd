extends CharacterBody2D

@export var speed = 30 #hoger is langzamer
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase: 
		velocity = (player.get_global_position() - position).normalized() * speed * delta
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.05)
	move_and_collide(velocity)
	move_and_slide()
		



func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	



func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

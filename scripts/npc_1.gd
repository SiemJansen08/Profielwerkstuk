extends CharacterBody2D

var speed = 30
var current_state =IDLE
var is_roaming = true
var player
var player_in_chatzone = false
var dir = Vector2.RIGHT
var start_pos


enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func ready():
	randomize()
	start_pos = position
	
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !Global.chatting:
		if dir.x == -1:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_walk")
		if dir.x == 1:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_walk")
		if dir.y == -1:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("back_walk")
		if dir.y == -1:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("front_walk")
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN ])
			MOVE: 
				move()
	if player_in_chatzone == true and Global.questlevel == 1 or Global.questlevel == 4 and player_in_chatzone or Global.questlevel == 10 and player_in_chatzone:
		Global.questlevel = 1.1
	if Input.is_action_just_pressed("chat") and player_in_chatzone:
		print("chatting with npc")
		$dialogue.start()
		is_roaming = false
		Global.chatting = true
		$AnimatedSprite2D.play("idle")


func choose(array):
	array.shuffle()
	return array.front()
	
func move():
	if !Global.chatting:
		velocity = dir * speed
		move_and_slide()


func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chatzone = true


func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chatzone = false


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_dialogue_dialogue_finished():
	Global.chatting = false
	$lip_camera.enabled = false
	is_roaming = true
	Global.cave_acces = true
	

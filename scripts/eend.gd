extends CharacterBody2D

var dir = 1
var error = false
var vliegen = false
var eerste_countdown = false
var random_nummer = RandomNumberGenerator.new()
@onready var anim = $AnimatedSprite2D

func _ready():
	$Timer.start()

func _physics_process(delta):
	
	if vliegen == false:
		if dir == 0:
			anim.play("idle")
			anim.flip_h = true
		elif dir == 1:
			anim.play("idle")
			anim.flip_h = false
	elif vliegen == true:
		if dir == 0:
			anim.play("vliegen")
			anim.flip_h = true
			velocity.x = 90
		elif dir == 1:
			anim.play("vliegen")
			anim.flip_h = false
			velocity.x = -90
			
		velocity.y = -35
		move_and_slide()	

	if Global.current_scene == "res://scenes/museum.tscn":
		$Vogels.queue_free()


func _on_timer_timeout():
	
	eerste_countdown = true
	
	if vliegen == false:
		dir = random_nummer.randi_range(0,1)
		$Timer.start()


func _on_area_2d_body_entered(body):
	if eerste_countdown == true and error == false:
		vliegen = true
		if Global.sound == true:
			$birdwings.play()
		error = true
		

	

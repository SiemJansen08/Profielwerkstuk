extends Sprite2D

var pickup = false

func _process(delta):
	if Input.is_action_just_pressed("secure") and pickup == true:
		Global.paintings = Global.paintings + 1
		self.queue_free()
		Global.questlevel = 11

func _on_area_2d_body_entered(body):
	pickup = true
	Global.questlevel = 11.1


func _on_area_2d_body_exited(body):
	pass # Replace with function body.

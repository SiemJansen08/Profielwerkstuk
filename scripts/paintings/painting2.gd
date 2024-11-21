extends Sprite2D

var pickup = false
var ready_play = false

func _process(delta):
	if Input.is_action_just_pressed("secure") and pickup == true:
		Global.paintings = Global.paintings + 1
		self.queue_free()
		Global.questlevel = 11

func _on_area_2d_body_entered(body):
	if body.has_method("player") and ready_play and Global.questlevel >= 11:
		pickup = true
		Global.questlevel = 11.1


func _on_start_timer_timeout():
	ready_play = true


func _on_area_2d_body_exited(body):
	pickup = false
	Global.questlevel = 11

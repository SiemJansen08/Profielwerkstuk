extends Sprite2D

signal grab

var pickup = false
var ready_play = false

func _process(delta):
	if Input.is_action_just_pressed("secure") and pickup == true:
		Global.acces_door_right = true
		self.queue_free()
		emit_signal("grab")


func _on_area_2d_body_entered(body):
	Global.questlevel = 13.1
	if body.has_method("player") and ready_play and Global.questlevel >= 11:
		pickup = true


func _on_start_timer_timeout():
	ready_play = true


func _on_area_2d_body_exited(body):
	pickup = false
	if Global.acces_door_left == true and Global.acces_door_right == false:
		Global.questlevel = 13.2
	elif Global.acces_door_left == false and Global.acces_door_right == true:
		Global.questlevel = 13.3
	elif Global.acces_door_left == false and Global.acces_door_right == false:
		Global.questlevel = 13
	elif Global.acces_door_left == true and Global.acces_door_right == true:
		Global.questlevel = 13.4

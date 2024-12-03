extends Button

var activate = true

func _physics_process(delta):
	if activate == true:
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
				grab_focus()
				activate = false
				print("gelukt")

extends Control

signal dialogue_finished

@export_file("*.json") var d_file

var dialogue = []
var current_dialogue_id = 0
var d_active = false


func _ready():
	$NinePatchRect.visible = false
	
	
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	
	
func load_dialogue():
	if Global.cave_win == false:
		var file = FileAccess.open("res://dialogue/Lip_dialogue1.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		return content
	elif Global.cave_win == true:
		var file = FileAccess.open("res://dialogue/Lip_dialogue2.json", FileAccess.READ)
		var content = JSON.parse_string(file.get_as_text())
		Global.bridge_acces = true
		Global.cave_acces = false
		return content
	
func _input(event):
	if !d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()


func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		emit_signal("dialogue_finished")
		return
		
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]["name"]
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]["text"]
	

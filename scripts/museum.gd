extends Node2D

var key_door_1 = false
@onready var healthbar = $player/Healthbar


func _ready():
	$TileMap/door_1/door_1_col.set_deferred("disabled", false)
	healthbar.init_health(Global.player_health)
	Global.player_health = Global.player_health + 20
	Global.questlevel = 6

func _process(delta):
	change_scenes()

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "museum":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()

func _on_museum_exit_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		change_scenes()

func _on_acces_door_1_body_entered(body):
	if key_door_1 == true:
		Global.questlevel = 8
	else:
		Global.questlevel = 7 


func _on_lasers_body_entered(body):
	Global.player_health = Global.player_health - 20
	healthbar.health = Global.player_health
	print(Global.player_health)

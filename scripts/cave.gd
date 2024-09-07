extends Node2D

@export var inkling_scene: PackedScene
var current_wave: int
var starting_nodes: int
var current_nodes: int
var wave_spawn_ended 

func _ready():
	current_wave = 0
	Global.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()

func _start():
	pass
	
func _process(delta):
	change_scenes()
	
	current_nodes = get_child_count()
	if wave_spawn_ended:
		position_to_next_wave()

func _on_cave_exit_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "cave":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()
			

func position_to_next_wave():
	if current_nodes == starting_nodes:
		if current_wave != 0:
			Global.moving_to_next_wave = true
		wave_spawn_ended = false
		#anim? 10:25 "how to spawn enemies in godot4" - devworm
		current_wave += 1
		if current_wave <= 3:
			Global.current_wave = current_wave
			await get_tree().create_timer(0.5).timeout
			prepare_spawn("inklings", 5.0, 5.0 ) #type , multiplier, spawns
			print("wave ", current_wave)
		else:
			if current_nodes == starting_nodes:
				Global.cave_win = true
				print("all enemies killed")
			
		
func prepare_spawn(type, multiplier, mob_spawns):
	var mob_amount = float(current_wave) * multiplier
	var mob_wait_time: float = 3.0
	print("mob_amount: ", mob_amount)
	var mob_spawn_rounds = mob_amount / mob_spawns
	spawn_type(type, mob_spawn_rounds, mob_wait_time)
	
func spawn_type(type, mob_spawn_rounds, mob_wait_time):
	if type == "inklings":
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var inkling1 = inkling_scene.instantiate()
				inkling1.global_position = $inkling_spawn_1.global_position
				var inkling2 = inkling_scene.instantiate()
				inkling2.global_position = $inkling_spawn_2.global_position
				var inkling3 = inkling_scene.instantiate()
				inkling3.global_position = $inkling_spawn_3.global_position
				var inkling4 = inkling_scene.instantiate()
				inkling4.global_position = $inkling_spawn_4.global_position
				var inkling5 = inkling_scene.instantiate()
				inkling5.global_position = $inkling_spawn_5.global_position
				add_child(inkling1)
				add_child(inkling2)
				add_child(inkling3)
				add_child(inkling4)
				add_child(inkling5)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
		wave_spawn_ended = true

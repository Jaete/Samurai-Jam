extends Node2D

var masked_enemy = preload("res://Objects/Entities/enemy.tscn")
@onready var bgm = $BGM
@onready var player = get_node("/root/Hero")

func _ready():
	Dialogic.timeline_ended.connect(_finished_intro_2)
	init_enemy(Vector2(-992,157), 3, true)
	init_enemy(Vector2(-1472,157), 3, true)
	init_enemy(Vector2(-864,-67), 3, true)
	init_enemy(Vector2(-1408,-803), 3, false)
	init_enemy(Vector2(-704, -643), 3, true)
	init_enemy(Vector2(-1632, -515), 3, true)
	init_enemy(Vector2(-1408, -1088), 3, true)
	init_enemy(Vector2(-928, -1411), 3, true)
	init_enemy(Vector2(-416, -1315), 3, true)
	init_enemy(Vector2(-1376, -1088), 3, true)
	player.get_node("Sprite").set_flip_h(true)
	player.get_node("FSM").set_physics_process(false)
	player.global_position = Vector2(100,12)
	#player.global_position = Vector2(-800,-1700)
	Dialogic.start("introsecond")
	pass

func init_enemy(pos: Vector2, type: int, have_lantern: bool):
	var enemy = masked_enemy.instantiate()
	enemy.position = pos
	enemy.ENEMY_TYPE = type
	if !have_lantern:
		enemy.get_node("Sprite").get_node("Lantern").set_visible(false)
	enemy.get_node("FSM").set_physics_process(false)
	add_child(enemy)

func _finished_intro_2():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies:
		enemy.get_node("FSM").set_physics_process(true)
	player.velocity.x = 0
	player.get_node("FSM").set_physics_process(true)
	pass

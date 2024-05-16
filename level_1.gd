extends Node2D

var masked_enemy = preload("res://Objects/Entities/enemy.tscn")
@onready var bgm = get_node("/root/Bgm")
@onready var player = get_node("/root/Hero")

func _ready():
	player.global_position = Vector2(0,0.9)
	Dialogic.timeline_ended.connect(_finished_intro)
	init_enemy(Vector2(-193,-20), 1, true)
	init_enemy(Vector2(224,100), 1, false)
	init_enemy(Vector2(480,353), 2, true)
	init_enemy(Vector2(229,1183), 2, true)
	init_enemy(Vector2(-355, 1180), 1, true)
	init_enemy(Vector2(-288, 798), 1, true)
	init_enemy(Vector2(416, 642), 2, false)
	#bgm.play()
	get_node("/root/Healthbar").set_visible(true)
	Dialogic.start("intro")
	player.get_node("FSM").set_physics_process(false)
	player.is_dead = false
	pass

func init_enemy(pos: Vector2, type: int, have_lantern: bool):
	var enemy = masked_enemy.instantiate()
	enemy.position = pos
	enemy.ENEMY_TYPE = type
	if !have_lantern:
		enemy.get_node("Sprite").get_node("Lantern").set_visible(false)
	enemy.get_node("FSM").set_physics_process(false)
	add_child(enemy)

func _finished_intro():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies:
		enemy.get_node("FSM").set_physics_process(true)
	player.velocity.x = 0
	player.get_node("FSM").set_physics_process(true)
	

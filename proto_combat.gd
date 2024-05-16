extends Node2D

@onready var masked_enemy = preload("res://Objects/Entities/enemy.tscn")

func _ready():
	init_enemy(Vector2(192,128), 3, true)

func init_enemy(pos: Vector2, type: int, have_lantern: bool):
	var enemy = masked_enemy.instantiate()
	enemy.position = pos
	enemy.ENEMY_TYPE = type
	if !have_lantern:
		enemy.get_node("Sprite").get_node("Lantern").set_visible(false)
	enemy.get_node("FSM").set_physics_process(false)
	add_child(enemy)

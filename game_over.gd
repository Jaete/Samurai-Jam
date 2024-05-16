extends Node2D

@onready var player: Player = get_node("/root/Hero")
@onready var level_1 = load("res://level_1.tscn")
@onready var menu = load("res://Objects/UX/main_menu.tscn")

func _ready():
	player.global_position = Vector2(0,0)

func _on_retry_pressed():
	player.health = player.max_health
	player.health_bar.set_value(player.health)
	var state = player.get_node("FSM").current_state
	player.get_node("FSM").get_node("State").change_state("Idle")
	get_tree().change_scene_to_packed(level_1)

func _on_menu_pressed():
	get_tree().change_scene_to_packed(menu)


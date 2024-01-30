class_name EnemyState
extends Node2D

signal state_transition()

@onready var animation: AnimationPlayer = $"../../Sprite/Masked"
@onready var enemy: Enemy = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../Sprite"
@onready var animation_handler: AnimationHandler = $"../AnimationHandler"
@onready var left_vision: Area2D = $"../../Left Vision"
@onready var right_vision: Area2D = $"../../Right Vision"
@onready var player: Player = get_node("/root/Hero")
@onready var health_bar: TextureProgressBar = $"../../Health"

var already_running: bool = false
var patrolling: bool = true

func _ready():
	match enemy.ENEMY_TYPE:
		1:
			sprite.sprite_frames = load("res://Assets/Animations/Masked Enemy/enemy_masked_1.tres")
			left_vision.set_monitoring(false)
			enemy.hp = 20
			health_bar.max_value = enemy.hp
			health_bar.value = enemy.hp
			health_bar.set_visible(false)
		2:
			sprite.sprite_frames = load("res://Assets/Animations/Masked Enemy/enemy_masked_2.tres")
			left_vision.set_monitoring(false)
			enemy.hp = 20
			health_bar.max_value = enemy.hp
			health_bar.value = enemy.hp
			health_bar.set_visible(false)
		3:
			sprite.sprite_frames = load("res://Assets/Animations/Masked Enemy/enemy_masked_3.tres")
			left_vision.set_monitoring(false)
			enemy.hp = 30
			health_bar.max_value = enemy.hp
			health_bar.value = enemy.hp
			health_bar.set_visible(false)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

func change_state(_new_state: String) -> void:
	state_transition.emit(self,_new_state)
	pass

func perform_state_action(_delta: float) -> void:
	pass

func set_direction():
	if enemy.velocity.x > 0:
		enemy.direction = 1
	elif enemy.velocity.x < 0:
		enemy.direction = -1

func _on_body_took_damage():
	change_state("Damage")

func _on_animation_player_animation_finished(_anim_name):
	pass # Replace with function body.

func _on_boss_animation_finished(_anim_name):
	pass # Replace with function body.

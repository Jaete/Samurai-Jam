class_name EnemyState
extends Node2D

signal state_transition()

@onready var animation: AnimationPlayer = $"../../Sprite/AnimationPlayer"
@onready var enemy: Enemy = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../Sprite"
@onready var animation_handler: AnimationHandler = $"../AnimationHandler"
@onready var left_vision: Area2D = $"../../Left Vision"
@onready var right_vision: Area2D = $"../../Right Vision"
@export var player: Player


var already_running: bool = false
var patrolling: bool = true

func _ready():
	match enemy.ENEMY_TYPE:
		1:
			sprite.sprite_frames = load("res://Assets/Animations/Masked Enemy/enemy_masked.tres")
			left_vision.set_monitoring(false)

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
	else:
		enemy.direction = enemy.direction


func _on_body_took_damage():
	change_state("Damage")
	print("here bro")

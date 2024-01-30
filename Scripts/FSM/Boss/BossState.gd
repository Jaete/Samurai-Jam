class_name BossState
extends Node2D

signal state_transition()

@onready var animation: AnimationPlayer = $"../../Sprite/Boss"
@onready var boss: Boss = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../Sprite"
@onready var animation_handler: AnimationHandler = $"../AnimationHandler"
@onready var player: Player = get_node("/root/Hero")
@onready var boss_health: TextureProgressBar = $"../../Healthbar/Texture"

var already_running: bool = false
var patrolling: bool = true

func _ready():
	sprite.sprite_frames = load("res://Assets/Animations/Boss/boss.tres")
	boss.hp = 20
	boss_health.max_value = boss.hp
	boss_health.set_value(boss.hp)
	boss_health.set_visible(false)

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
	if boss.velocity.x > 0:
		boss.direction = 1
	elif boss.velocity.x < 0:
		boss.direction = -1
	else:
		boss.direction = boss.direction

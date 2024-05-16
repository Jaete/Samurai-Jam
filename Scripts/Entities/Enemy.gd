class_name Enemy
extends CharacterBody2D

signal dead()

var ENEMY_TYPE: int
var target: Player

var jump_height: float = 100
var time_to_peak: float = 0.4
var gravity_multiplier: float = 2
var double_jump_height: float = 70

var gravity: float
var jump_speed: float
var fall_gravity: float
var double_jump_speed: float

var last_damage_direction: int

var boss_triggered: bool = false
var patrolling: bool = true
var original_position: Vector2

const MOVE_SPEED: float = 120
var direction: float

var jump_left: int = 2

var attacking: bool = false
var attack_cooldown: bool = false
var already_sorted: bool = false

var hp: int
var max_hp: int

var sequential_hits: int = 0

func _ready():
	jump_speed = -(2 * jump_height) / time_to_peak
	gravity = (2 * jump_height) / pow(time_to_peak, 2)
	fall_gravity = gravity * gravity_multiplier
	double_jump_speed = -(2 * double_jump_height) / time_to_peak
	match ENEMY_TYPE:
		1:
			max_hp = 10
			hp = 10
		2:
			max_hp = 15
			hp = 15
		3:
			max_hp = 12
			hp = 12
	target = get_node("/root/Hero")

func ground_jump():
	if jump_left > 0:
		jump_left -= 1
		velocity.y = jump_speed
	pass

func double_jump():
	if jump_left > 1:
		jump_left -= 2
	elif jump_left > 0:
		jump_left -= 1
	velocity.y = double_jump_speed

func _on_dead():
	target.set("kill_count", target.kill_count + 1)
	pass # Replace with function body.

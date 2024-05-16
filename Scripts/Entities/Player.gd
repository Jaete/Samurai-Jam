class_name Player
extends CharacterBody2D

@onready var health_bar: TextureProgressBar = get_node("/root/Healthbar/Texture")

@export var jump_height: float
@export var time_to_peak: float
@export var gravity_multiplier: float
@export var double_jump_height: float
@export var wall_slide: float
@export var MOVE_SPEED: float = 120
@export var friction: float = 20
@onready var fall_cast: RayCast2D = $"BodyCollisor/Fall RayCast"

var gravity: float
var jump_speed: float
var fall_gravity: float
var double_jump_speed: float

var direction: float
var last_damage_direction: float

@export var max_health: int = 10
var health: int

var jump_left: int = 2
var attacking_low: bool = false
var attacking_high: bool = false
var defending_low: bool = false
var defending_high: bool = false
var is_dead: bool = false
var kill_count: int = 7

func _ready():
	jump_speed = -(2 * jump_height) / time_to_peak
	gravity = (2 * jump_height) / pow(time_to_peak, 2)
	fall_gravity = gravity * gravity_multiplier
	double_jump_speed = -(2 * double_jump_height) / time_to_peak
	wall_slide = fall_gravity * 0.1
	health = max_health
	health_bar.set_max(max_health)
	health_bar.set_value(health)

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


func _on_body_took_damage():
	pass

func _on_death_died():
	var game_over = preload("res://Objects/UX/game_over.tscn")
	get_tree().change_scene_to_packed(game_over)

extends Area2D

@onready var player: Player = get_node("/root/Hero")
@export var jump_height: float
@export var time_to_peak: float
@export var gravity_multiplier: float

var hit_count = 0
var box_gravity: float
var jump_speed: float
var fall_gravity: float

func _ready():
	gravity = (2 * jump_height) / pow(time_to_peak, 2)
	fall_gravity = gravity * gravity_multiplier
	
func _physics_process(delta):
	get_parent().velocity.y += fall_gravity * delta
	get_parent().move_and_slide()

func _on_area_entered(area):
	var current_state = str(player.get_node("FSM").current_state)
	if area.name == "Sword" and current_state.contains("Attack"):
		handle_hit()

func handle_hit():
	get_parent().get_node("CharacterBody2D").set_frame(hit_count)
	hit_count += 1
	
	if hit_count == 6:
		get_parent().queue_free()

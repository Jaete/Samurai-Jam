class_name Player
extends CharacterBody2D

@export var jump_height: float
@export var time_to_peak: float
@export var gravity_multiplier: float
@export var double_jump_height: float
@export var wall_slide: float

var gravity: float
var jump_speed: float
var fall_gravity: float
var double_jump_speed: float


const MOVE_SPEED: float = 120
var direction: float

var jump_left: int = 2
var sheated: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_speed = -(2 * jump_height) / time_to_peak
	gravity = (2 * jump_height) / pow(time_to_peak, 2)
	fall_gravity = gravity * gravity_multiplier
	double_jump_speed = -(2 * double_jump_height) / time_to_peak
	wall_slide = fall_gravity * 0.1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
#	direction = Input.get_axis("Move_Left","Move_Right")
#	velocity.x = lerp(100.0, MOVE_SPEED, delta) * direction
#	if Input.is_action_just_pressed("Jump"):
#		velocity.y = jump_speed
#	if velocity.y > 0 or !Input.is_action_pressed("Jump"):
#		velocity.y += fall_gravity * delta
#	else:
#		velocity.y += gravity * delta	
#	move_and_slide()
	pass

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

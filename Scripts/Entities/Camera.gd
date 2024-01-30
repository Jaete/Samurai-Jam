class_name GameCamera
extends Camera2D

@onready var player: Player =  get_node("/root/Hero")
var player_state: String

var shake_amount : float = 0
var default_offset : Vector2 = offset
var pos_x : int
var pos_y : int

@onready var timer : Timer = get_node("CameraShakeTimer")
@onready var tween : Tween = create_tween()

func _ready():
	set_process(true)
	randomize()
	
func _process(_delta: float):
	global_position = player.global_position
	offset = Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)

func shake(time: float, amount: float):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()

func _on_camera_shake_timer_timeout():
	set_process(false)
	Tween.interpolate_value(self, "offset", 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)

class_name Fall
extends State

@export var landing_sound: AudioStreamPlayer2D
var fall_velocity: float = 0
@onready var fall_time: Timer = $Timer

func enter() -> void:
	fall_time.start(1)
	pass

func exit() -> void:
	fall_time.stop()
	pass

func update(_delta: float) -> void:
	print("FALL TIME: " + str(fall_time.time_left))
	animation_handler.play_animation(player, self.name, animation, sprite)
	player.direction = Input.get_axis("Move_Left","Move_Right")
	if player.direction > 0 && player.velocity.x < 0:
		player.velocity.x += player.friction * 4
	if player.direction < 0 && player.velocity.x > 0:
		player.velocity.x -= player.friction * 4
	if abs(player.velocity.x) < player.MOVE_SPEED:
		player.velocity.x += player.MOVE_SPEED * 2 * _delta * player.direction
	player.velocity.y += player.fall_gravity * _delta
	player.move_and_slide()
	should_change_state()
	fall_velocity = player.velocity.y
	pass

func should_change_state() -> void:
	if player.is_on_floor():
		landing_sound.play()
		change_state("Idle")
		return
	elif Input.is_action_just_pressed("Jump") and player.jump_left > 0:
		change_state("Jump")
	elif player.is_on_wall_only() && (player.get_last_slide_collision().get_collider().get("name") == "Ground") && Input.get_axis("Move_Left","Move_Right") != 0:
		fall_time.stop()
		change_state("Wall Slide")
	pass

func perform_state_action(_delta: float) -> void:
	pass

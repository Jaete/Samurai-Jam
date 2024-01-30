class_name Fall
extends State

@export var landing_sound: AudioStreamPlayer2D

func enter() -> void:
	pass

func exit() -> void:
	player.velocity.x -= player.velocity.x * 0.9
	pass

func update(_delta: float) -> void:
	animation_handler.play_animation(player, self.name, animation, sprite)
	player.direction = Input.get_axis("Move_Left","Move_Right")
	if player.direction > 0 && player.velocity.x < 0:
		player.velocity.x += 5
	if player.direction < 0 && player.velocity.x > 0:
		player.velocity.x -= 5
	if abs(player.velocity.x) < player.MOVE_SPEED:
		player.velocity.x += player.MOVE_SPEED * 2 * _delta * player.direction
	player.velocity.y += player.fall_gravity * _delta
	player.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if player.is_on_floor():
		landing_sound.play()
		change_state("Idle")
	elif Input.is_action_just_pressed("Jump") and player.jump_left > 0:
		change_state("Jump")
	if player.is_on_wall_only() && (player.get_last_slide_collision().get_collider().get("name") == "Ground") && player.direction != 0:
		change_state("Wall Slide")
	pass

func perform_state_action(_delta: float) -> void:
	pass

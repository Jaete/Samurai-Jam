class_name Fall
extends State


func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	should_play_sheated_animation()
	player.direction = Input.get_axis("Move_Left","Move_Right")
	player.velocity.x = lerp(0.0, player.MOVE_SPEED, player.MOVE_SPEED * _delta) * player.direction
	player.velocity.y += player.fall_gravity * _delta
	player.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if player.is_on_floor():
		change_state("Idle")
	elif Input.is_action_just_pressed("Jump") and player.jump_left > 0:
		change_state("Jump")
	if player.is_on_wall_only():
		change_state("Wall Slide")
	pass

func perform_state_action(_delta: float) -> void:
	pass

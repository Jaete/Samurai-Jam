class_name Jump
extends State


func enter() -> void:
	if player.is_on_floor() || player.is_on_wall():
		player.ground_jump()
	else:
		player.double_jump()
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	should_play_sheated_animation()
	player.direction = Input.get_axis("Move_Left","Move_Right")
	player.velocity.x = lerp(0.0, player.MOVE_SPEED, player.MOVE_SPEED * _delta) * player.direction
	player.velocity.y += player.gravity * _delta
	if Input.is_action_just_pressed("Jump"):
		player.double_jump()
	player.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if player.velocity.y > 0 or !Input.is_action_pressed("Jump"):
		change_state("Fall")
	if player.is_on_wall_only():
		change_state("Wall Slide")
	pass

func perform_state_action(_delta: float) -> void:
	pass

class_name WallSlide
extends State

func enter() -> void:
	player.velocity.y = 0
	if player.jump_left == 0:
		player.jump_left += 1
	player.velocity.y = 0
	player.move_and_slide()
	animation_handler.play_animation(player, self.name, animation, sprite)
	await animation.animation_finished
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	player.direction = Input.get_axis("Move_Left","Move_Right")
	should_change_state()
	player.velocity.y += player.wall_slide * _delta
	player.move_and_slide()
	pass

func should_change_state() -> void:
	if player.is_on_floor():
		change_state("Idle")
	if Input.is_action_just_pressed("Jump") && player.direction > 0 && sprite.is_flipped_h():
		change_state("Jump")
	if Input.is_action_just_pressed("Jump") && player.direction < 0 && !sprite.is_flipped_h():
		change_state("Jump")
	if !player.is_on_wall_only():
		change_state("Fall")
	pass

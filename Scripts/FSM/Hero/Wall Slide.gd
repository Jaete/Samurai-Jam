class_name WallSlide
extends State

func enter() -> void:
	player.velocity.y = 0
	player.velocity.x = 0
	if player.jump_left == 0:
		player.jump_left += 1
	player.move_and_slide()
	animation_handler.play_animation(player, self.name, animation, sprite)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	should_change_state()
	#player.velocity.x = lerp(0.0, player.MOVE_SPEED, player.MOVE_SPEED * _delta) * player.direction
	player.velocity.y += player.wall_slide * _delta
	player.move_and_slide()
	pass

func should_change_state() -> void:
	if player.is_on_floor() && player.direction != 0:
		change_state("Move")
	if player.is_on_floor():
		change_state("Idle")
	if Input.is_action_just_pressed("Jump") && Input.is_action_pressed("Move_Right") && sprite.is_flipped_h():
		change_state("Jump")
	if Input.is_action_just_pressed("Jump") && Input.is_action_pressed("Move_Left") && !sprite.is_flipped_h():
		change_state("Jump")
	if !player.is_on_wall_only():
		change_state("Fall")
	pass

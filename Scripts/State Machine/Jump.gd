class_name Jump
extends State

func enter() -> void:
		player.holding_jump = true
		player.start_jump_buffer_timer()
		if (not player.can_hold_jump and player.can_ground_jump()) or player.can_double_jump():
			player.jump()
		if player.can_ground_jump() and player.can_hold_jump:
			player.jump()
		pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	animation_handler.play_animation(player, self.name, sprite)
	if player.velocity.y > 0:
		state_transition.emit(self, "Fall")
	player.move_and_slide()

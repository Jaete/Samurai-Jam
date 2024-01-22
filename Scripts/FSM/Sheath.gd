class_name Sheath
extends State

func enter():
	animation_handler.play_animation(player, self.name, animation, sprite)
	player.velocity.x = 0
	should_change_state()
	player.move_and_slide()
	pass

func exit():
	player.sheated = true
	pass

func update(_delta: float):
	pass

func should_change_state():
		if Input.get_axis("Move_Left","Move_Right"):
			if !animation_handler.is_animation_finished(animation):
				await animation.animation_finished
			change_state("Move")
		elif Input.is_action_just_pressed("Attack"):
			change_state("Attack 1")
		elif Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_DOWN):
			change_state("Defend Low")
		elif Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_UP):
			change_state("Defend High")
		else:
			if get_parent().current_state.name != "Idle":
				if !animation_handler.is_animation_finished(animation):
					await animation.animation_finished
				change_state("Idle")

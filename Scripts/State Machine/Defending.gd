class_name Defending
extends State


func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if !already_running:
		already_running = true
		animation_handler.play_animation(player, self.name, sprite)
		player.velocity.x = 0
		should_change_state()
		player.move_and_slide()
		already_running = false

func should_change_state() -> void:
	if Input.get_axis("Move_Left","Move_Right"):
		if !animation_handler.is_animation_finished(sprite):
			await sprite.animation_finished
		change_state("Move")
	elif Input.is_action_just_pressed("Jump"):
		if !animation_handler.is_animation_finished(sprite):
			await sprite.animation_finished
		change_state("Jump")
	elif Input.is_action_just_pressed("Attack"):
		if !animation_handler.is_animation_finished(sprite):
			await sprite.animation_finished
		change_state("Attack 1")
	elif Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_UP):
		if self.name == "Defend Low":
			if !animation_handler.is_animation_finished(sprite):
				await sprite.animation_finished
			change_state("Defend High")
	elif Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_DOWN):
		if self.name == "Defend High":
			if !animation_handler.is_animation_finished(sprite):
				await sprite.animation_finished
			change_state("Defend Low")
	else:
		if !animation_handler.is_animation_finished(sprite):
				await sprite.animation_finished
		change_state("Sheath")

func change_state(new_state: String) -> void:
	state_transition.emit(self, new_state)

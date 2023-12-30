class_name Defending
extends State


func enter():
	pass

func exit():
	pass

func update(_delta: float):
	animation_handler.play_animation(player, self.name)
	player.velocity.x = 0
	if !Input.is_anything_pressed():
		if sprite.sprite_frames.get_frame_count(sprite.animation) == (sprite.get_frame() + 1):
			state_transition.emit(self, "Sheath")
		else:
			await sprite.animation_finished
			state_transition.emit(self, "Sheath")
	if Input.get_axis("Move_Left","Move_Right"):
		if sprite.sprite_frames.get_frame_count(sprite.animation) == (sprite.get_frame() + 1):
			state_transition.emit(self, "Move")
		else:
			await sprite.animation_finished
			state_transition.emit(self, "Move")
	if Input.is_action_just_pressed("Jump"):
		if sprite.sprite_frames.get_frame_count(sprite.animation) == (sprite.get_frame() + 1):
			state_transition.emit(self, "Jump")
		else:
			await sprite.animation_finished
			state_transition.emit(self, "Jump")
	if Input.is_action_just_pressed("Attack"):
		if sprite.sprite_frames.get_frame_count(sprite.animation) == (sprite.get_frame() + 1):
			state_transition.emit(self, "Attack 1")
		else:
			await sprite.animation_finished
			state_transition.emit(self, "Attack 1")
	player.move_and_slide()

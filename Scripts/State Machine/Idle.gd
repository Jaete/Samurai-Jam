class_name Idle
extends State

func enter():
	pass
	
func exit():
	pass

func update(_delta: float):
	animation_handler.play_animation(player, self.name)
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self, "Attack 1")
	if Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_DOWN):
		state_transition.emit(self, "Defend Low")
	if Input.get_axis("Move_Right","Move_Left"):
		state_transition.emit(self, "Move")
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		state_transition.emit(self, "Jump")
	if not player.is_on_floor():
		state_transition.emit(self, "Fall")

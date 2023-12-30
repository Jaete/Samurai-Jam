class_name Move
extends State

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	animation_handler.play_animation(player, self.name)
	if !Input.is_anything_pressed():
		state_transition.emit(self,"Idle")
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self,"Attack 1")
	if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_DOWN):
			state_transition.emit(self, "Defend Low")	
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		state_transition.emit(self,"Jump")
	if not player.is_on_floor():
		state_transition.emit(self,"Fall")
	player.move_and_slide()
	
func _input(event):
	player.acc.x = 0
	if Input.is_action_pressed("Move_Left"):
		player.acc.x = -player.max_acceleration

	if Input.is_action_pressed("Move_Right"):
		player.acc.x = player.max_acceleration
	

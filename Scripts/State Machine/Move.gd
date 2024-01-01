class_name Move
extends State

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	animation_handler.play_animation(player, self.name, sprite)
	if Input.is_action_just_pressed("Attack"):
		state_transition.emit(self,"Attack 1")
	if Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_DOWN):
			state_transition.emit(self, "Defend Low")
	if Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_UP):
			state_transition.emit(self, "Defend High")		
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		state_transition.emit(self,"Jump")
	if not player.is_on_floor():
		state_transition.emit(self,"Fall")
	if player.acc.x == 0:
		state_transition.emit(self,"Idle")	
	player.move_and_slide()
	
func _input(_event):
	player.acc.x = 0
	if Input.is_action_pressed("Move_Left"):
		player.acc.x = player.max_acceleration * -1 
	if Input.is_action_pressed("Move_Right"):
		player.acc.x = player.max_acceleration
	

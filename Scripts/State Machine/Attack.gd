class_name Attack
extends State

func enter():
	if $"../../AttackTimer".is_stopped():
		$"../../AttackTimer".start(0.7)
	else:
		$"../../AttackTimer".stop()

func exit():
	$"../../AttackTimer".stop()
	pass

func update(_delta: float):
	animation_handler.play_animation(player, self.name)
	if self.name == "Attack 2":
		if player.is_on_floor():
			player.velocity.x = 0
		if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_DOWN):
			state_transition.emit(self, "Defend Low")
	if self.name == "Attack 1":
		if player.is_on_floor():
			player.velocity.x = player.velocity.x * 0.6
		if Input.is_action_just_pressed("Attack"):
			state_transition.emit(self, "Attack 2")	
		if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_DOWN):
			state_transition.emit(self, "Defend Low")
	player.move_and_slide()
	
func _on_attack_timer_timeout():
	state_transition.emit(self, "Sheath")

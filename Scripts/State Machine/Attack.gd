class_name Attack
extends State

func enter() -> void:
	if $"../../AttackTimer".is_stopped():
		$"../../AttackTimer".start(0.7)
	else:
		$"../../AttackTimer".stop()

func exit() -> void:
	$"../../AttackTimer".stop()

func update(_delta: float) -> void:
	if !already_running:
		already_running = true
		animation_handler.play_animation(player, self.name, sprite)
		should_change_state()
		perform_state_action()
		player.move_and_slide()
		already_running = false
	
func should_change_state() -> void:
	match self.name:
		"Attack 2":
			if player.is_on_floor():
				player.velocity.x = 0
			if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_DOWN):
				change_state("Defend Low")
			if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_UP):
				change_state("Defend High")
		"Attack 1":
			if player.is_on_floor():
				player.velocity.x = player.velocity.x * 0.6
			if Input.is_action_just_pressed("Attack"):
				change_state("Attack 2")	
			if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_UP):
				change_state("Defend High")
			if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_DOWN):
				change_state("Defend Low")

func change_state(new_state: String)-> void:
	state_transition.emit(self, new_state)

func _on_attack_timer_timeout() -> void:
	change_state("Sheath")

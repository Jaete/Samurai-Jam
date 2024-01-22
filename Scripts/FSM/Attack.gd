class_name Attack
extends State

var attack_time: SceneTreeTimer

func enter() -> void:
	attack_time = get_tree().create_timer(0.7, true, true)
	if player.sheated || self.name == "Attack 2":
		animation_handler.play_animation(player, self.name, animation, sprite)
	else:
		animation_handler.play_animation(player, self.name + " Unsheath", animation, sprite)

func exit() -> void:
	player.sheated = false
	pass

func update(_delta: float) -> void:
	print("Sheated: ", player.sheated)
	if player.is_on_floor():
		player.velocity.x -= player.velocity.x * 0.05
	if !animation.is_playing():
		player.velocity.x = 0
	should_change_state()
	player.move_and_slide()

func should_change_state() -> void:
	match self.name:
		"Attack 2":
			if player.is_on_floor():
				player.velocity.x = 0
			if Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_DOWN):
				if !animation_handler.is_animation_finished(animation):
					await animation.animation_finished
				change_state("Defend Low")
			elif Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_UP):
				if !animation_handler.is_animation_finished(animation):
					await animation.animation_finished
				change_state("Defend High")
			elif attack_time.time_left == 0:
				if !animation_handler.is_animation_finished(animation):
					await animation.animation_finished
				change_state("Sheath")
		"Attack 1":
			if Input.is_action_just_pressed("Attack"):
				change_state("Attack 2")
			elif Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_DOWN):
#				if !animation_handler.is_animation_finished(animation):
#					await animation.animation_finished
				change_state("Defend Low")
			elif Input.is_physical_key_pressed(KEY_D) and Input.is_physical_key_pressed(KEY_UP):
#				if !animation_handler.is_animation_finished(animation):
#					await animation.animation_finished
				change_state("Defend High")
			elif Input.get_axis("Move_Left", "Move_Right"):
				if !animation_handler.is_animation_finished(animation):
					await animation.animation_finished
					change_state("Move")
			elif attack_time.time_left == 0:
#				if !animation_handler.is_animation_finished(animation):
#					await sprite.animation_finished
				change_state("Sheath")

func unsheath_sword() -> void:
	player.sheated = false
	pass

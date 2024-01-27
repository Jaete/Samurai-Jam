class_name Move
extends State

var stair_gravity

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	should_play_sheated_animation()
	perform_state_action(_delta)
	should_change_state()
	pass

func should_change_state() -> void:
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		change_state("Jump")
	elif not player.is_on_floor():
		change_state("Fall")
	elif Input.is_action_just_pressed("Attack"):
		change_state("Attack 1")
	elif !Input.is_anything_pressed():
		if player.sheated:
			change_state("Idle")
		else:
			change_state("Sheath")
	pass

func perform_state_action(_delta: float) -> void:
	player.direction = Input.get_axis("Move_Left","Move_Right")
	player.velocity.x = lerp(0.0, player.MOVE_SPEED, player.MOVE_SPEED * _delta) * player.direction
	player.velocity.y += player.fall_gravity * _delta
	player.move_and_slide()
	pass

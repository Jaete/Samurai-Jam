class_name Move
extends State

var stair_gravity

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	animation_handler.play_animation(player, self.name, animation, sprite)
	perform_state_action(_delta)
	should_change_state()
	pass

func should_change_state() -> void:
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		change_state("Jump")
	elif not player.is_on_floor():
		change_state("Fall")
	if Input.is_action_just_pressed("Attack 1"):
		change_state("Attack 1")
	elif Input.is_action_just_pressed("Attack 2"):
		change_state("Attack 2")
		return
	elif Input.is_action_pressed("Defend Low"):
		change_state("Defend Low")
		return
	elif Input.is_action_pressed("Defend High"):
		change_state("Defend High")
		return
	elif !Input.is_anything_pressed():
		change_state("Idle")
		return
	pass

func perform_state_action(_delta: float) -> void:
	player.direction = Input.get_axis("Move_Left","Move_Right")
	if player.direction > 0 && player.velocity.x < 0:
		player.velocity.x += player.friction * 4
	if player.direction < 0 && player.velocity.x > 0:
		player.velocity.x -= player.friction * 4
	if abs(player.velocity.x) < player.MOVE_SPEED:
		player.velocity.x += player.MOVE_SPEED * 3 * _delta * player.direction#lerpf(0.0, player.MOVE_SPEED, player.MOVE_SPEED * _delta) * player.direction
	player.velocity.y += player.fall_gravity * _delta
	player.move_and_slide()
	pass

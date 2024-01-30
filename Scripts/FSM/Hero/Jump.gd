class_name Jump
extends State

@export var jump_sound: AudioStreamPlayer2D

func enter() -> void:
	jump_sound.play()
	if player.is_on_floor() || player.is_on_wall():
		player.ground_jump()
	else:
		player.double_jump()
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	animation_handler.play_animation(player, self.name, animation, sprite)
	player.direction = Input.get_axis("Move_Left","Move_Right")
	#if player.direction > 0 && player.velocity.x < 0:
		#player.velocity.x += 5
	#if player.direction < 0 && player.velocity.x > 0:
		#player.velocity.x -= 5
	#if abs(player.velocity.x) < player.MOVE_SPEED:
		#player.velocity.x += player.MOVE_SPEED * 2 * _delta * player.direction
	player.velocity.x = player.MOVE_SPEED * player.direction
	player.velocity.y += player.gravity * _delta
	if Input.is_action_just_pressed("Jump"):
		player.double_jump()
	player.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if player.velocity.y > 0 or !Input.is_action_pressed("Jump"):
		change_state("Fall")
	if player.is_on_wall_only() && (player.get_last_slide_collision().get_collider().get("name") == "Ground") && player.direction != 0:
		change_state("Wall Slide")
	pass

func perform_state_action(_delta: float) -> void:
	pass

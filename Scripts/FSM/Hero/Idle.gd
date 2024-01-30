class_name Idle
extends State

func enter():
	player.jump_left = 2
	animation_handler.play_animation(player, self.name, animation, sprite)
	pass

func exit():
	pass

func update(_delta: float):
	if player.velocity.x > 0:
		if player.velocity.x - 20 > 0:
			player.velocity.x -= player.friction * 2
		else:
			player.velocity.x = 0
	else:
		if player.velocity.x + 0 < 0:
			player.velocity.x += player.friction * 2
		else:
			player.velocity.x = 0
		
		
	player.move_and_slide()
	should_change_state()
	pass

func should_change_state():
	if !player.is_on_floor():
		change_state("Fall")
		return
	elif Input.is_action_just_pressed("Jump") and player.is_on_floor():
		change_state("Jump")
		return
	elif Input.get_axis("Move_Left","Move_Right"):
		change_state("Move")
		return
	elif Input.is_action_just_pressed("Attack 1"):
		change_state("Attack 1")
		return
	elif Input.is_action_just_pressed("Attack 2"):
		change_state("Attack 2")
		return
	elif Input.is_action_pressed("Defend") && Input.is_physical_key_pressed(KEY_DOWN):
		change_state("Defend Low")
		return
	elif Input.is_action_pressed("Defend") && Input.is_physical_key_pressed(KEY_UP):
		change_state("Defend High")
		return
	

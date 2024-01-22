class_name Idle
extends State

func enter():
	player.jump_left = 2
	animation_handler.play_animation(player, self.name, animation, sprite)
	pass

func exit():
	pass

func update(_delta: float):
	should_change_state()
	pass

func should_change_state():
	if not player.is_on_floor():
		change_state("Fall")
		return
	elif Input.is_action_just_pressed("Jump") and player.is_on_floor():
		change_state("Jump")
		return
	elif Input.get_axis("Move_Left","Move_Right"):
		change_state("Move")
		return
	elif Input.is_action_just_pressed("Attack"):
		change_state("Attack 1")
	elif left_collisor.is_colliding() or right_collisor.is_colliding():
		print("here bro")
		return
	

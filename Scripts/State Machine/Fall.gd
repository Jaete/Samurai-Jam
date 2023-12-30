class_name Fall
extends State

func enter():
	pass

func exit():
#	player.velocity.x = 0
	pass

func update(_delta: float):
	animation_handler.play_animation(player, self.name)
#	player.velocity.y += player.gravity * _delta
	player.move_and_slide()
	if player.is_on_floor():
		state_transition.emit(self, "Idle")
	

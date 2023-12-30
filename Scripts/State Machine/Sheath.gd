class_name Sheath
extends State

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	animation_handler.play_animation(player, self.name)
	player.velocity.x = 0
	player.move_and_slide()
	await sprite.animation_finished
	state_transition.emit(self, "Idle")
	

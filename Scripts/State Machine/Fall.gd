class_name Fall
extends State

func enter() -> void:
	pass

func exit() -> void:
#	player.velocity.x = 0
	pass

func update(_delta: float) -> void:
	animation_handler.play_animation(player, self.name, sprite)
	should_change_state()
	player.move_and_slide()
	

func should_change_state() -> void:
	if player.is_on_floor():
		state_transition.emit(self, "Idle")

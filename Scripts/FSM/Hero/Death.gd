class_name Death
extends State

func enter() -> void:
	player.is_dead = true
	animation_handler.play_animation(player, self.name, animation, sprite)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

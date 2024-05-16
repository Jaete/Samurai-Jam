class_name Death
extends State

signal died()

func enter() -> void:
	player.is_dead = true
	animation_handler.play_animation(player, self.name, animation, sprite)
	await animation.animation_finished
	died.emit()
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

func _on_died():
	pass
	

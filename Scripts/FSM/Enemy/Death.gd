class_name EnemyDeath
extends EnemyState

func enter() -> void:
	animation_handler.play_animation(enemy, self.name, animation, sprite)

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

class_name EnemyDeath
extends EnemyState

func enter() -> void:
	if !animation.is_playing():
		animation_handler.play_animation(enemy, self.name, animation, sprite)

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

func _on_masked_animation_finished(anim_name):
	pass

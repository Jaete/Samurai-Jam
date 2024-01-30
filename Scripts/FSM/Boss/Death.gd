class_name BossDeath
extends BossState

func enter() -> void:
	if !animation.is_playing():
		animation_handler.play_animation(boss, self.name, animation, sprite, true)
func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

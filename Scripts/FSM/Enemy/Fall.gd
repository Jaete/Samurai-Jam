class_name EnemyFall
extends EnemyState

func enter() -> void:
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	enemy.velocity.y += enemy.fall_gravity * _delta
	enemy.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if enemy.is_on_floor():
		change_state("Idle")
	pass

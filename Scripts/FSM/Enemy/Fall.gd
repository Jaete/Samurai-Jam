class_name EnemyFall
extends EnemyState

@export var landing_sound: AudioStreamPlayer2D

func enter() -> void:
	enemy.already_sorted = false
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
		landing_sound.play()
		change_state("Idle")
	pass

class_name BossFall
extends BossState

@export var landing_sound: AudioStreamPlayer2D

func enter() -> void:
	boss.already_sorted = false
	animation_handler.play_animation(boss, self.name, animation, sprite, true)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	boss.velocity.y += boss.fall_gravity * _delta
	boss.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if boss.is_on_floor():
		landing_sound.play()
		change_state("Idle")
	pass

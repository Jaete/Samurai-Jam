class_name EnemyFall
extends EnemyState

@onready var landing_sound: AudioStreamPlayer2D = $"Landing Sound"
@onready var fall_time: Timer = $EnemyTimer

func enter() -> void:
	enemy.already_sorted = false
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	fall_time.start(1)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	enemy.velocity.y += enemy.fall_gravity * _delta
	enemy.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if enemy.is_on_floor() && fall_time.get_time_left() <= 0.3:
		fall_time.stop()
		enemy.hp -= 2
		landing_sound.play()
		change_state("Damage")
		return
	elif enemy.is_on_floor() && fall_time.get_time_left() <= 0.5:
		enemy.hp -= 1
		fall_time.stop()
		landing_sound.play()
		change_state("Damage")
		return
	elif enemy.is_on_floor():
		landing_sound.play()
		change_state("Idle")
	pass

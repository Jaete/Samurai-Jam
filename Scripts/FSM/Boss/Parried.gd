class_name BossParried
extends BossState

@export var parry_sound: AudioStreamPlayer2D
@export var knockback_force: float = 200
var stagger_timer: SceneTreeTimer

func enter() -> void:
	parry_sound.play()
	stagger_timer = get_tree().create_timer(1.5, false, true)
	animation_handler.play_animation(boss, self.name, animation, sprite, true)
	#set_direction()
	print("ENEMY DIRECTION: " + str(boss.direction))
	if boss.direction == 1:
		boss.velocity.x = knockback_force * -1
		print("ENEMY VELOCITY: " + str(boss.velocity.x))
	elif boss.direction < 0:
		boss.velocity.x = knockback_force
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if boss.velocity.x != 0:
		if boss.velocity.x > 0:
			boss.velocity.x -= knockback_force * 2 * _delta
		else:
			boss.velocity.x += knockback_force * 2 * _delta
	if boss.velocity.x < 1 && boss.velocity.x > 0:
		boss.velocity.x = 0
	boss.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if stagger_timer.get_time_left() == 0:
		change_state("Move")
	pass

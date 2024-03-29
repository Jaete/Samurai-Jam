class_name EnemyParried
extends EnemyState

@export var parry_sound: AudioStreamPlayer2D
@export var knockback_force: float = 200
var stagger_timer: SceneTreeTimer

func enter() -> void:
	parry_sound.play()
	stagger_timer = get_tree().create_timer(1.5, false, true)
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	set_direction()
	print("ENEMY DIRECTION: " + str(enemy.direction))
	if enemy.direction == 1:
		enemy.velocity.x = knockback_force * -1
		print("ENEMY VELOCITY: " + str(enemy.velocity.x))
	elif enemy.direction < 0:
		enemy.velocity.x = knockback_force
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if enemy.velocity.x != 0:
		if enemy.velocity.x > 0:
			enemy.velocity.x -= knockback_force * 2 * _delta
		else:
			enemy.velocity.x += knockback_force * 2 * _delta
	if enemy.velocity.x < 1 && enemy.velocity.x > 0:
		enemy.velocity.x = 0
	enemy.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if stagger_timer.get_time_left() == 0:
		change_state("Move")
	pass

class_name EnemyDamage
extends EnemyState

var damage_timer: SceneTreeTimer

@export var knockback_force: float

func enter() -> void:
	damage_timer = get_tree().create_timer(0.3, false, true)
	if sprite.is_flipped_h():
		enemy.velocity.x += knockback_force
	else:
		enemy.velocity.x -= knockback_force
	enemy.move_and_slide()
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if enemy.velocity.x != 0:
		if enemy.velocity.x > 0:
			enemy.velocity.x -= knockback_force * 0.01
		else:
			enemy.velocity.x -= knockback_force * 0.01
	enemy.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if animation_handler.is_animation_finished(animation):
		if enemy.patrolling:
			enemy.patrolling = false
		change_state("Move")
	pass

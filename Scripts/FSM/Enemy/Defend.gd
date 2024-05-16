class_name EnemyDefend
extends EnemyState

var defend_time: SceneTreeTimer

func enter() -> void:
	#defend_time = get_tree().create_timer(1, false, true)
	enemy.velocity.x = 0
	enemy.move_and_slide()
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	should_change_state()
	pass

func should_change_state() -> void:
	if !(enemy.target.attacking_low || enemy.target.attacking_high) && animation_handler.is_animation_finished(animation):
		change_state("Move")
	pass

func _on_body_took_damage():
	if enemy.get_node("FSM").current_state.name == self.name:
		if enemy.sequential_hits >= 2:
			return
		else:
			perfection_rate = 4
			enemy.attack_cooldown = false
			change_state("Damage")
	else:
		return

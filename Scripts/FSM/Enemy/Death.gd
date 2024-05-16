class_name EnemyDeath
extends EnemyState

func enter() -> void:
	enemy.dead.emit()
	if !animation.is_playing():
		animation_handler.play_animation(enemy, self.name, animation, sprite)
	enemy.get_node("Health").queue_free()

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

func _on_body_took_damage():
	pass

func _on_masked_animation_finished(anim_name):
	if anim_name == "Death Left" || anim_name == "Death Right":
		pass

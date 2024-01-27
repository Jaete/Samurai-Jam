class_name EnemyAttack
extends EnemyState

var attack_time: SceneTreeTimer

func enter() -> void:
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	should_change_state()
	pass

func should_change_state() -> void:
	if animation_handler.is_animation_finished(animation):
		change_state("Move")

func _on_body_took_damage():
	change_state("Damage")

func _on_sword_parried():
	change_state("Parried")

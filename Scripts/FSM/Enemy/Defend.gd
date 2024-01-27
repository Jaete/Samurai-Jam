class_name EnemyDefend
extends EnemyState

var defend_time: SceneTreeTimer

func enter() -> void:
	defend_time = get_tree().create_timer(1, false, true)
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
	if !enemy.target.attacking && defend_time.get_time_left() == 0:
		change_state("Move")
	pass


func _on_body_took_damage():
	change_state("Damage")

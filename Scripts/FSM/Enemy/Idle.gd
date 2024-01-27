class_name EnemyIdle
extends EnemyState

var idle_time: SceneTreeTimer

func enter():
	enemy.velocity.x = 0
	enemy.jump_left = 1
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	idle_time = get_tree().create_timer(1, false, true)
	pass

func exit():
	pass

func update(_delta: float):
	set_direction()
	get_direction_and_vision()
	should_change_state()
	pass

func should_change_state():
	if !enemy.is_on_floor():
		change_state("Fall")
	if (idle_time.time_left == 0 && enemy.patrolling) || !enemy.patrolling:
		change_state("Move")
	pass

func set_direction():
	if enemy.velocity.x > 0:
		enemy.direction = 1
	elif enemy.velocity.x < 0:
		enemy.direction = -1
	else:
		enemy.direction = enemy.direction

func get_direction_and_vision() -> void:
	if enemy.direction > 0:
		left_vision.set_monitoring(false)
		left_vision.set_visible(false)
		right_vision.set_monitoring(true)
		right_vision.set_visible(true)
	elif enemy.direction < 0:
		left_vision.set_monitoring(true)
		left_vision.set_visible(true)
		right_vision.set_monitoring(false)
		right_vision.set_visible(false)

func _on_right_vision_area_entered(area):
	if area.is_in_group("Player"):
		enemy.patrolling = false


func _on_left_vision_area_entered(area):
	if area.is_in_group("Player"):
		enemy.patrolling = false

func _on_body_took_damage():
	change_state("Damage")

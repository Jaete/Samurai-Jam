class_name EnemyMove
extends EnemyState

var patrol_walk_time: SceneTreeTimer
var is_facing_left: bool = false

@export var patrol_time: float
var player_distance_x: float
var player_distance_y: float
var player_in_front: bool

func enter() -> void:
	if enemy.patrolling:
		patrol_walk_time = get_tree().create_timer(patrol_time, false, true)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	set_direction()
	animation_handler.play_animation(enemy, self.name, animation, sprite)
	get_direction_and_vision()
	if enemy.patrolling:
		patrol(_delta)
	else:
		approach(_delta)
	enemy.move_and_slide()
	player_distance_x = abs(enemy.global_position.x - enemy.target.global_position.x)
	player_distance_y = abs(enemy.global_position.y - enemy.target.global_position.y)
	if enemy.direction == 1:
		player_in_front = (enemy.target.global_position.x > enemy.global_position.x)
	else:
		player_in_front = (enemy.target.global_position.x < enemy.global_position.x)
	should_change_state()

func should_change_state() -> void:
	if enemy.patrolling && patrol_walk_time.time_left == 0:
		is_facing_left = !is_facing_left
		change_state("Idle")
		return
	elif !enemy.patrolling && player_distance_x < 65 && enemy.target.attacking:
		change_state("Defend")
	elif !enemy.patrolling && player_distance_x < 60 && player_distance_y < 20 && player_in_front:
		change_state("Attack 1")
	elif !enemy.is_on_floor():
		change_state("Fall")

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

func patrol(_delta: float) -> void:
	if is_facing_left:
		enemy.velocity.x -= enemy.MOVE_SPEED * _delta
	else:
		enemy.velocity.x += enemy.MOVE_SPEED * _delta
	pass

func approach(_delta: float) -> void:
	if enemy.target.global_position.x > enemy.global_position.x:
		if enemy.velocity.x < 0:
			enemy.velocity.x = 0
		enemy.velocity.x += enemy.MOVE_SPEED * _delta
	elif enemy.target.global_position.x < enemy.global_position.x:
		if enemy.velocity.x > 0:
			enemy.velocity.x = 0
		enemy.velocity.x -= enemy.MOVE_SPEED * _delta
	pass

func _on_right_vision_area_entered(area):
	if area.is_in_group("Player"):
		enemy.patrolling = false

func _on_left_vision_area_entered(area):
	if area.is_in_group("Player"):
		enemy.patrolling = false

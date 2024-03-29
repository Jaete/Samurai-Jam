class_name EnemyMove
extends EnemyState

var patrol_walk_time: SceneTreeTimer
var is_facing_left: bool = false

@export var patrol_time: float
var player_distance_x: float
var player_distance_y: float
var player_in_front: bool

var perfection_rate: int = 4
var select_attack: int
var boss_regular_attacks: int = 0
var teleported_too_much: int = 0
var attack_2_casted = false

@onready var attack_cooldown_time: Timer = $"Attack Cooldown"

func enter() -> void:
	if enemy.patrolling:
		patrol_walk_time = get_tree().create_timer(patrol_time, false, true)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	set_direction()
	if !enemy.attack_cooldown:
		animation_handler.play_animation(enemy, self.name, animation, sprite)
	get_direction_and_vision()
	if enemy.patrolling:
		patrol(_delta)
	elif !enemy.patrolling && enemy.attack_cooldown:
		hold_position()
	elif !enemy.patrolling:
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
	match enemy.ENEMY_TYPE:
		1, 2:
			if player.is_dead:
				change_state("Idle")
			if enemy.patrolling && patrol_walk_time.time_left == 0:
				is_facing_left = !is_facing_left
				change_state("Idle")
				return
			if !enemy.patrolling && player_distance_x < 100 && enemy.target.attacking_low || enemy.target.attacking_high:
				if enemy.ENEMY_TYPE == 1:
					change_state("Defend Low")
				else:
					change_state("Defend High")
				return
			elif !enemy.patrolling && player_distance_x < 60 && player_distance_y < 20 && player_in_front && !enemy.attack_cooldown:
				if enemy.ENEMY_TYPE == 1:
					change_state("Attack 1")
				else:
					change_state("Attack 2")
				return
			elif !enemy.is_on_floor():
				change_state("Fall")
				return
		3:
			if enemy.patrolling && patrol_walk_time.time_left == 0:
				is_facing_left = !is_facing_left
				change_state("Idle")
				return
			elif !enemy.patrolling && player_distance_x < 100 && enemy.target.attacking_low:
				if perfection_rate > 0:
					perfection_rate -= 1
					change_state("Defend Low")
				else:
					perfection_rate = 4
					change_state("Defend High")
				return
			elif !enemy.patrolling && player_distance_x < 100 && enemy.target.attacking_high:
				if perfection_rate > 0:
					perfection_rate -= 1
					change_state("Defend High")
				else:
					perfection_rate = 4
					change_state("Defend Low")
				return
			elif !enemy.patrolling && player_distance_x < 60 && player_distance_y < 20 && player_in_front && !enemy.attack_cooldown:
				if !enemy.patrolling && player_distance_x < 60 && enemy.target.defending_high:
					if perfection_rate > 0:
						perfection_rate -= 1
						change_state("Attack 1")
					else:
						perfection_rate = 4
						change_state("Attack 2")
					return
				elif !enemy.patrolling && player_distance_x < 60 && enemy.target.defending_low:
					if perfection_rate > 0:
						perfection_rate -= 1
						change_state("Attack 2")
					else:
						perfection_rate = 4
						change_state("Attack 1")
					return
				elif !enemy.patrolling && player_distance_x < 60:
					select_attack = randi_range(1,100)
					if select_attack > 50:
						change_state("Attack 1")
					if select_attack <= 50:
						change_state("Attack 2")
					return
			elif !enemy.is_on_floor():
				change_state("Fall")
				return

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
	if enemy.target.global_position.x < enemy.global_position.x:
		if enemy.velocity.x > 0:
			enemy.velocity.x = 0
		if enemy.velocity.x <= 0:
			enemy.velocity.x -= enemy.MOVE_SPEED *  _delta
	elif enemy.target.global_position.x > enemy.global_position.x:
		if enemy.velocity.x < 0:
			enemy.velocity.x = 0
		if enemy.velocity.x >= 0:
			enemy.velocity.x += enemy.MOVE_SPEED * _delta
	pass

func hold_position():
	enemy.velocity.x = 0
	var direction = animation_handler.get_entity_direction(enemy)
	sprite.set_animation("Attack 2")
	match direction:
		"Left":
			sprite.flip_h = true
		"Right":
			sprite.flip_h = false
	sprite.set_frame(3)
	if attack_cooldown_time.is_stopped():
		attack_cooldown_time.start(0.5)

func _on_right_vision_area_entered(area):
	if area.is_in_group("Player"):
		enemy.patrolling = false

func _on_left_vision_area_entered(area):
	if area.is_in_group("Player"):
		enemy.patrolling = false

func _on_attack_cooldown_timeout():
	enemy.attack_cooldown = false

func _on_sword_parried():
	enemy.attack_cooldown = false

func _on_body_took_damage():
	perfection_rate = 4
	enemy.attack_cooldown = false
	change_state("Damage")

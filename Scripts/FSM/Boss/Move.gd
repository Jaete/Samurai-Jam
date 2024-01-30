class_name BossMove
extends BossState

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
	if boss.patrolling:
		patrol_walk_time = get_tree().create_timer(patrol_time, false, true)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	set_direction()
	if !boss.attack_cooldown:
		animation_handler.play_animation(boss, self.name, animation, sprite, true)
		approach(_delta)
	elif boss.attack_cooldown:
		boss_hold()
	boss.move_and_slide()
	player_distance_x = abs(boss.global_position.x - boss.target.global_position.x)
	player_distance_y = abs(boss.global_position.y - boss.target.global_position.y)
	if boss.direction == 1:
		player_in_front = (boss.target.global_position.x > boss.global_position.x)
	else:
		player_in_front = (boss.target.global_position.x < boss.global_position.x)
	should_change_state()

func should_change_state() -> void:
	if player.is_dead:
		change_state("Idle")
	if !boss.boss_triggered:
		change_state("Idle")
	if player_distance_x < 80 && player_in_front:
		select_attack = randi_range(1,100)
		if select_attack <= 80 :
			boss_regular_attacks += 1
			change_state("Attack 1")
		if select_attack > 80 && select_attack < 99:
			boss_regular_attacks += 1
			change_state("Attack 2")
		if select_attack >= 99 || boss_regular_attacks == 5:
			boss_regular_attacks = 0
			change_state("Cast Spell")
		return
	if player_distance_x > 250:
		select_attack = randi_range(1,100)
		if select_attack <= 70:
			teleported_too_much += 1
			change_state("Teleport")
		elif select_attack > 70 || teleported_too_much == 3:
			teleported_too_much = 0
			change_state("Cast Spell")

func patrol(_delta: float) -> void:
	if is_facing_left:
		boss.velocity.x -= boss.MOVE_SPEED * _delta
	else:
		boss.velocity.x += boss.MOVE_SPEED * _delta
	pass

func approach(_delta: float) -> void:
	if boss.target.global_position.x < boss.global_position.x:
		if boss.velocity.x > 0:
			boss.velocity.x = 0
		if boss.velocity.x <= 0:
			boss.velocity.x -= boss.MOVE_SPEED *  _delta
	elif boss.target.global_position.x > boss.global_position.x:
		if boss.velocity.x < 0:
			boss.velocity.x = 0
		if boss.velocity.x >= 0:
			boss.velocity.x += boss.MOVE_SPEED * _delta
	pass

func hold_position():
	boss.velocity.x = 0
	var direction = animation_handler.get_entity_direction(boss)
	sprite.set_animation("Attack 2")
	match direction:
		"Left":
			sprite.flip_h = true
		"Right":
			sprite.flip_h = false
	sprite.set_frame(3)
	if attack_cooldown_time.is_stopped():
		attack_cooldown_time.start(0.1)

func boss_hold():
	boss.velocity.x = 0
	if attack_cooldown_time.is_stopped():
		attack_cooldown_time.start(0.1)

func _on_attack_cooldown_timeout():
	boss.attack_cooldown = false

func _on_sword_parried():
	boss.attack_cooldown = false


func _on_body_boss_dead():
	change_state("Death")

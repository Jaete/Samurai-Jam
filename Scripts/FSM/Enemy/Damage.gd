class_name EnemyDamage
extends EnemyState

var damage_timer: SceneTreeTimer

@onready var knockback_force: float = 240
@onready var damage_sound: AudioStreamPlayer2D = $DamageSound
@onready var knockback_lose_ratio: int = 4

func enter() -> void:
	if enemy.sequential_hits >= 2:
		if enemy.hp > 0:
			enemy.hp -= 1
		health_bar.set_value(enemy.hp)
		golden_boy()
		should_change_state()
	else:
		enemy.sequential_hits += 1
		health_bar.max_value = enemy.max_hp
		health_bar.value = enemy.hp
		if !health_bar.is_visible():
			health_bar.set_visible(true)
		if enemy.hp > 0:
			enemy.hp -= 1
		health_bar.set_value(enemy.hp)
		damage_sound.play()
		damage_timer = get_tree().create_timer(0.3, false, true)
		if enemy.last_damage_direction == 1:
			enemy.velocity.x = knockback_force
		elif enemy.last_damage_direction == -1:
			enemy.velocity.x = knockback_force * -1
		enemy.move_and_slide()
		animation_handler.play_animation(enemy, self.name, animation, sprite)
		pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if !enemy.is_on_floor():
		enemy.velocity.y = enemy.fall_gravity * _delta 
	if enemy.velocity.x != 0:
		if enemy.velocity.x > 0 && (enemy.velocity.x - knockback_force * 2 * _delta) < 0:
			enemy.velocity.x = 0
		elif enemy.velocity.x > 0:
			enemy.velocity.x -= knockback_force * knockback_lose_ratio * _delta
		if enemy.velocity.x < 0 && (player.velocity.x + knockback_force * 2 * _delta) > 0:
			enemy.velocity.x = 0
		elif enemy.velocity.x < 0:
			enemy.velocity.x += knockback_force * knockback_lose_ratio * _delta
	enemy.move_and_slide()
	pass

func should_change_state() -> void:
	if enemy.hp == 0:
		change_state("Death")
		return
	if enemy.patrolling:
		enemy.patrolling = false
	change_state("Move")
	pass

func _on_masked_animation_finished(_anim_name):
	if enemy.get_node("FSM").current_state.name == self.name:
		if enemy.sequential_hits >= 2:
			enemy.attack_cooldown = false
		else:
			perfection_rate = 4
			enemy.attack_cooldown = false
		should_change_state()
	else:
		return
		
func golden_boy():
	sprite.set_modulate(Color(255,255,98,255))
	var timer = get_tree().create_timer(0.1, false, true)
	await timer.timeout
	sprite.set_modulate(Color(255,255,255,255))
	var timer_2 = get_tree().create_timer(0.1, false, true)
	await timer_2.timeout
	sprite.set_modulate(Color(255,255,98,255))
	var timer_3 = get_tree().create_timer(0.1, false, true)
	await timer_3.timeout
	sprite.set_modulate(Color(255,255,255,255))
	var timer_4 = get_tree().create_timer(0.1, false, true)
	await timer_4.timeout

func _on_body_took_damage():
	pass

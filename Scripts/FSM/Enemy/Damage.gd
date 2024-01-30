class_name EnemyDamage
extends EnemyState

var damage_timer: SceneTreeTimer

@export var knockback_force: float
@export var damage_sound: AudioStreamPlayer2D
@export var knockback_lose_ratio: int

func enter() -> void:
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
	player.move_and_slide()
	enemy.move_and_slide()
	pass

func should_change_state() -> void:
	if enemy.hp == 0 && enemy.ENEMY_TYPE != 4:
		change_state("Death")
		return
	elif enemy.patrolling:
		enemy.patrolling = false
	change_state("Move")
	pass

func _on_animation_player_animation_finished(_anim_name):
	if !(_anim_name == "Death Left" || _anim_name == "Death Right"):
		should_change_state()
	pass

func _on_body_took_damage():
	change_state(self.name)

func _on_boss_animation_finished(_anim_name):
	should_change_state()
	pass

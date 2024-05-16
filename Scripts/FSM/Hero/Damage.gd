class_name Damage
extends State

var damage_timer: SceneTreeTimer

@export var knockback_force: float
@export var knockback_lose_ratio: float
@export var damage_sound: AudioStreamPlayer2D

func enter() -> void:
	if player.health > 0:
		player.health -= 1
	player.health_bar.set_value(player.health)
	damage_sound.play()
	damage_timer = get_tree().create_timer(1.5, false, true)
	animation_handler.play_animation(player, self.name, animation, sprite)
	if player.last_damage_direction == 1:
		player.velocity.x = knockback_force
	elif player.last_damage_direction == -1:
		player.velocity.x = knockback_force * -1
	player.velocity.y = player.jump_speed
	player.move_and_slide()
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if !player.is_on_floor():
		player.velocity.y = player.fall_gravity * _delta 
	if player.velocity.x != 0:
		if player.velocity.x > 0 && (player.velocity.x - knockback_force * 2 * _delta) < 0:
			player.velocity.x = 0
		elif player.velocity.x > 0:
			player.velocity.x -= knockback_force * knockback_lose_ratio * _delta
		if player.velocity.x < 0 && (player.velocity.x + knockback_force * 2 * _delta) > 0:
			player.velocity.x = 0
		elif player.velocity.x < 0:
			player.velocity.x += knockback_force * knockback_lose_ratio * _delta
	player.move_and_slide()
	pass

func should_change_state() -> void:
	if player.health == 0:
		change_state("Death")
		return
	elif Input.get_axis("Move_Left","Move_Right"):
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Move")
		return
	elif Input.is_action_pressed("Jump"):
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Jump")
		return
	elif Input.is_action_pressed("Attack 1"):
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Attack 1")
		return
	elif Input.is_action_pressed("Attack 2"):
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Attack 2")
		return
	else:
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Idle")
		return

func _on_animation_player_animation_finished(_anim_name):
	if player.get_node("FSM").current_state.name == self.name:
		should_change_state()
		

class_name Damage
extends State

var damage_timer: SceneTreeTimer

@export var knockback_force: float

func enter() -> void:
	damage_timer = get_tree().create_timer(0.3, false, true)
	if sprite.is_flipped_h():
		player.velocity.x += knockback_force
	else:
		player.velocity.x -= knockback_force
	player.move_and_slide()
	animation_handler.play_animation(player, self.name, animation, sprite)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if player.velocity.x != 0:
		if player.velocity.x > 0:
			player.velocity.x -= knockback_force * 0.2
		else:
			player.velocity.x -= knockback_force * 0.2
	player.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if Input.get_axis("Move_Left","Move_Right"):
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Move")
		return
	elif Input.is_action_pressed("Jump"):
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Jump")
		return
	elif Input.is_action_pressed("Attack"):
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Attack 1")
		return
	else:
		if !animation_handler.is_animation_finished(animation):
			await animation.animation_finished
		change_state("Idle")
		return

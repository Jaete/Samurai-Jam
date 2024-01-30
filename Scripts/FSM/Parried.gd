class_name Parried
extends State

@export var knockback_force: float = 200
var stagger_timer: SceneTreeTimer

func enter() -> void:
	stagger_timer = get_tree().create_timer(1.5, false, true)
	animation_handler.play_animation(player, self.name, animation, sprite)
	if animation_handler.direction == "Left":
		player.velocity.x += knockback_force
	else:
		player.velocity.x -= knockback_force
	player.move_and_slide()
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if player.velocity.x != 0:
		if player.velocity.x > 0 && (player.velocity.x - knockback_force * 2 * _delta) < 0:
			player.velocity.x = 0
		elif player.velocity.x > 0:
			player.velocity.x -= knockback_force * 2 * _delta
		if player.velocity.x < 0 && (player.velocity.x + knockback_force * 2 * _delta) > 0:
			player.velocity.x = 0
		elif player.velocity.x < 0:
			player.velocity.x += knockback_force * 2 * _delta
	player.move_and_slide()
	should_change_state()
	pass

func should_change_state() -> void:
	if stagger_timer.get_time_left() == 0:
		change_state("Sheath")
	pass

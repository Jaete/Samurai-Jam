class_name Parried
extends State

@export var knockback_force: float = 150
@onready var parry_sound: AudioStreamPlayer2D = $"ParrySound"
var stagger_timer: SceneTreeTimer

func enter() -> void:
	parry_sound.play()
	var camera: GameCamera = get_parent().get_parent().get_node("Camera")
	camera.shake(0.2, 6)
	stagger_timer = get_tree().create_timer(1.5, false, true)
	animation_handler.play_animation(player, self.name, animation, sprite)
	if animation_handler.direction == "Left":
		player.velocity.x += knockback_force
	elif animation_handler.direction == "Right":
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
		if Input.is_action_pressed("Attack 1"):
			change_state("Attack 1")
		elif Input.is_action_pressed("Attack 2"):
			change_state("Attack 2")
		elif Input.is_action_pressed("Defend Low"):
			change_state("Defend Low")
		elif Input.is_action_pressed("Defend High"):
			change_state("Defend High")
		elif Input.is_action_pressed("Jump"):
			change_state("Jump")
		elif Input.get_axis("Move_Left","Move_Right"):
			change_state("Move")
		elif !Input.is_anything_pressed():
			change_state("Idle")

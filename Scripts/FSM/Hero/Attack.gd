class_name Attack
extends State

@export var attack_sound: AudioStreamPlayer2D
@export var attack_sound_2: AudioStreamPlayer2D

func enter() -> void:
	if self.name == "Attack 1":
		player.attacking_low = true
		attack_sound.play()
	else:
		player.attacking_high = true
		attack_sound_2.play()
	animation_handler.play_animation(player, self.name, animation, sprite)
	pass

func exit() -> void:
	player.attacking_high = false
	player.attacking_low = false
	pass

func update(_delta: float) -> void:
	if player.is_on_floor() && player.velocity.x != 0:
		player.velocity.x -= player.velocity.x * 0.15
	if !animation.is_playing():
		player.velocity.x = 0
	player.move_and_slide()

func should_change_state() -> void:
	match self.name:
		"Attack 2":
			if Input.is_action_just_pressed("Attack 1"):
				change_state("Attack 1")
			elif Input.is_action_pressed("Defend Low"):
				player.attacking_low = false
				player.attacking_high = false
				change_state("Defend Low")
			elif Input.is_action_pressed("Defend High"):
				player.attacking_low = false
				player.attacking_high = false
				change_state("Defend High")
			elif Input.get_axis("Move_Left", "Move_Right"):
				player.attacking_low = false
				player.attacking_high = false
				change_state("Move")
			else:
				player.attacking_low = false
				player.attacking_high = false
				change_state("Idle")
		"Attack 1":
			if Input.is_action_just_pressed("Attack 2"):
				change_state("Attack 2")
			elif Input.is_action_pressed("Defend Low"):
				player.attacking_low = false
				player.attacking_high = false
				change_state("Defend Low")
			elif Input.is_action_pressed("Defend High"):
				player.attacking_low = false
				player.attacking_high = false
				change_state("Defend High")
			elif Input.get_axis("Move_Left", "Move_Right"):
				player.attacking_low = false
				player.attacking_high = false
				change_state("Move")
			else:
				player.attacking_low = false
				player.attacking_high = false
				change_state("Idle")

func _on_sword_enemy_parried():
	player.attacking_low = false
	player.attacking_high = false
	change_state("Parried")

func _on_animation_player_animation_finished(_anim_name):
	if player.get_node("FSM").current_state.name == self.name:
		should_change_state()

class_name Defend
extends State

var defense_direction: String = ""

func enter() -> void:
	if animation_handler.direction == "Left":
		player.direction = -1
	else:
		player.direction = 1
	if self.name == "Defend Low":
		player.defending_low = true
	else:
		player.defending_high = true
	animation_handler.play_animation(player, self.name + defense_direction, animation, sprite)
	pass

func exit() -> void:
	player.defending_high = false
	player.defending_low = false
	pass
	
func update(_delta: float) -> void:
	should_change_state()
	pass

func should_change_state() -> void:
	if Input.is_action_just_pressed("Jump"):
		change_state("Jump")
	elif Input.is_action_pressed("Attack 2"):
		change_state("Attack 2")
	elif Input.is_action_pressed("Attack 1"):
		change_state("Attack 1")
		return
	elif Input.get_axis("Move_Left","Move_Right"):
		change_state("Move")
		return
	elif Input.is_action_just_pressed("Defend High") :
		change_state("Defend High")
		return
	elif Input.is_action_just_pressed("Defend Low"):
		change_state("Defend Low")
		return
	elif !Input.is_anything_pressed():
		change_state("Idle")
		return
	pass

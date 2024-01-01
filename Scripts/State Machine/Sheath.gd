class_name Sheath
extends State

var currentName: String = "Sheath"
var selfName: String
var attack_count: int = 0

func enter():
	pass

func exit():
	pass

func update(_delta: float):
		animation_handler.play_animation(player, self.name, sprite)
		player.velocity.x = 0
		should_change_state()
		perform_state_action()
		player.move_and_slide()

func should_change_state():
	if !already_running:
		already_running = true
		if Input.get_axis("Move_Left","Move_Right"):
			if !animation_handler.is_animation_finished(sprite):
				await sprite.animation_finished
			state_transition.emit(self, "Move")
		elif Input.is_action_just_pressed("Attack"):
				state_transition.emit(self, "Attack 1")
		elif Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_DOWN):
				state_transition.emit(self, "Defend Low")
		elif Input.is_key_pressed(KEY_D) and Input.is_key_pressed(KEY_UP):
				state_transition.emit(self, "Defend High")
		else:
			if get_parent().current_state.name != "Idle":
				if !animation_handler.is_animation_finished(sprite):
					await sprite.animation_finished
				state_transition.emit(self, "Idle")
		already_running = false

func perform_state_action():
	pass

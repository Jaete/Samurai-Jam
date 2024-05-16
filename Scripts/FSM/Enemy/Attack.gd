class_name EnemyAttack
extends EnemyState

var attack_time: SceneTreeTimer

@onready var attack_1_sound: AudioStreamPlayer2D = $"../Attack 1/Attack 1 Sound"
@onready var attack_2_sound: AudioStreamPlayer2D = $"../Attack 2/Attack 2 Sound"

func enter() -> void:
	if self.name == "Attack 1" && enemy.ENEMY_TYPE != 4:
		attack_1_sound.play()
	if self.name == "Attack 2" && enemy.ENEMY_TYPE != 4:
		attack_2_sound.play()
	attack_time = get_tree().create_timer(3, false, true)
	enemy.attacking = true
	animation_handler.play_animation(enemy, self.name, animation, sprite, true)

func exit() -> void:
	enemy.attacking = false
	enemy.attack_cooldown = true
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	change_state("Move")

func _on_body_took_damage():
	if enemy.get_node("FSM").current_state.name == self.name:
		if enemy.sequential_hits >= 2:
			enemy.sequential_hits = 0
			return
		else:
			perfection_rate = 4
			enemy.attack_cooldown = false
			change_state("Damage")
	else:
		return

func _on_sword_parried():
	change_state("Parried")

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

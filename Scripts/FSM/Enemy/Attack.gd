class_name EnemyAttack
extends EnemyState

var attack_time: SceneTreeTimer

@export var attack_1_sound: AudioStreamPlayer2D
@export var attack_2_sound: AudioStreamPlayer2D

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
	change_state("Damage")

func _on_sword_parried():
	change_state("Parried")

func _on_boss_animation_finished(_anim_name):
	if enemy.get_node("FSM").current_state.name == self.name:
		should_change_state()

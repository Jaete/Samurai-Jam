class_name BossAttack
extends BossState

var attack_time: SceneTreeTimer

@export var attack_1_sound: AudioStreamPlayer2D
@export var attack_2_sound: AudioStreamPlayer2D
@export var attack_boss_charge: AudioStreamPlayer2D
@export var attack_boss_slash: AudioStreamPlayer2D

func enter() -> void:
	attack_time = get_tree().create_timer(3, false, true)
	boss.attacking = true
	animation_handler.play_animation(boss, self.name, animation, sprite, true)

func exit() -> void:
	boss.attacking = false
	boss.attack_cooldown = true
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	change_state("Move")

func _on_sword_parried():
	change_state("Parried")

func _on_boss_animation_finished(_anim_name):
	if boss.get_node("FSM").current_state.name == self.name:
		should_change_state()

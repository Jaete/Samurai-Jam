class_name BossTeleport
extends BossState

var teleport_timer: SceneTreeTimer
var exit_position: float

func enter() -> void:
	animation_handler.play_animation(boss, self.name, animation, sprite, true)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	var animation_position: float = animation_handler.get_animation_position(animation)
	if animation_position >= 1.0 && animation_position <= 1.90:
		boss.global_position.y = player.global_position.y - 400
		boss.global_position.x = player.global_position.x
	if animation_position >= 1.95 && animation_position <= 1.98:
		if player.get_node("Sprite").is_flipped_h():
			exit_position = player.global_position.x + 80
		else:
			exit_position = player.global_position.x - 80
		boss.global_position.x = exit_position
		boss.global_position.y = player.global_position.y - 15
	pass

func should_change_state() -> void:
	change_state("Fall")
	pass

func _on_boss_animation_finished(_anim_name):
	if _anim_name == "Teleport Left" || _anim_name == "Teleport Right":
		should_change_state()

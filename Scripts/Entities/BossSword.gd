class_name BossSword
extends Area2D

signal parried()

@onready var boss: Boss = get_parent()
@onready var player: Player = get_node("/root/Hero")

func _on_area_entered(area):
	var current_state: String = str(boss.get_node("FSM").current_state.name)
	var player_current_state: String = str(player.get_node("FSM").current_state.name)
	var position_x: float = boss.global_position.x
	var player_position_x: float = player.global_position.x
	var hit_direction: String = check_damage_direction(position_x, player_position_x)
	if hit_direction == player.get_node("FSM").get_node("AnimationHandler").direction:
		return
	elif area.is_in_group("Player Sword") && current_state.contains("Attack") && player_current_state.contains("Attack"):
		if current_state.contains("Attack") && player_current_state.contains("Attack"):
			parried.emit()
	elif area.is_in_group("Player Sword") && current_state.contains("Attack") && player_current_state.contains("Defend"):
		if current_state == "Attack 1" && player_current_state == "Defend High":
			parried.emit()
	pass

func check_damage_direction(position_x: float, enemy_position_x: float):
	var damage_direction: float = enemy_position_x  - position_x
	if damage_direction > 0:
		return "Right"
	else:
		return "Left"

class_name Sword
extends Area2D

signal enemy_parried()

@onready var player: Player = get_node("/root/Hero")

func _on_area_entered(area):
	if !area.get_parent() is Enemy:
		return
	var enemy = area.get_parent()
	var enemy_current_state: String = str(enemy.get_node("FSM").current_state.name)
	var current_state: String = str(player.get_node("FSM").current_state.name)
	if area.is_in_group("Enemy Sword") && current_state.contains("Attack") && enemy_current_state.contains("Defend"):
		if current_state == "Attack 1" && enemy_current_state == "Defend Low":
			enemy_parried.emit()
		if current_state == "Attack 2" && enemy_current_state == "Defend High":
			enemy_parried.emit()
		elif current_state.contains("Attack") && enemy_current_state.contains("Attack"):
			if current_state == "Attack 1" && enemy_current_state == "Attack 2":
				enemy_parried.emit()
			elif current_state == "Attack 2" && enemy_current_state == "Attack 1":
				enemy_parried.emit()

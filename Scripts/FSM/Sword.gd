extends Area2D

signal enemy_parried()

func _on_area_entered(area):
	var current_state: String = str(get_parent().get_node("FSM").current_state)
	if area.is_in_group("Enemy Sword") && current_state.contains("Attack"):
		enemy_parried.emit()

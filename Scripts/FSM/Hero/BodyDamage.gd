class_name PlayerBody
extends Area2D

signal took_damage()

func _on_area_entered(area):
	#==== ENVIRONMENT RELATED DETECTION ====#
	if area.name == "Spike":
		took_damage.emit()
		return
	#==== COMBAT RELATED DETECTION ====#
	var player: CharacterBody2D = get_node("/root/Hero")
	var current_state: String = player.get_node("FSM").current_state.name
	if area.is_in_group("Spell Area") && current_state != "Defend High":
		took_damage.emit()
		return
	if area.is_in_group("Spell Area") && current_state == "Defend High":
		return
	var non_combat_states: Array = [
	"Move",
	"Idle",
	"Jump",
	"Fall",
	"Wall Slide",
	"Damage",
	"Parried"
	]
	var entity: CharacterBody2D = area.get_parent()
	var player_position_x: float = player.global_position.x
	var player_direction: String = player.get_node("FSM").get_node("AnimationHandler").direction
	var entity_position_x: float = entity.global_position.x
	var enemy_state: String = entity.get_node("FSM").current_state.name
	var is_non_combat: bool
	for state in non_combat_states:
		if state == current_state:
			is_non_combat = true
			break
	if area.is_in_group("Enemy Sword") && enemy_state.contains("Attack") && (entity is Enemy || entity is Boss):
		if is_non_combat:
			check_damage_direction(player, player_position_x, entity_position_x)
			took_damage.emit()
		elif player_position_x < entity_position_x && player_direction == "Left":
			check_damage_direction(player, player_position_x, entity_position_x)
			took_damage.emit()
		elif player_position_x > entity_position_x && player_direction == "Right": 
			check_damage_direction(player, player_position_x, entity_position_x)
			took_damage.emit()
		elif current_state == "Defend Low" && enemy_state == "Attack 2":
			check_damage_direction(player, player_position_x, entity_position_x)
			took_damage.emit()
		elif current_state == "Defend High" && enemy_state == "Attack 1":
			check_damage_direction(player, player_position_x, entity_position_x)
			took_damage.emit()
		elif current_state.contains("Attack") && enemy_state.contains("Attack"):
			check_damage_direction(player, player_position_x, entity_position_x)
			took_damage.emit()
		elif entity is Boss:
			if enemy_state == "Attack 2":
				check_damage_direction(player, player_position_x, entity_position_x)
				took_damage.emit()
			else:
				if !current_state == "Defend High":
					check_damage_direction(player, player_position_x, entity_position_x)
					took_damage.emit()
		pass
		
func check_damage_direction(player: Player, position_x: float, enemy_position_x: float):
	var damage_direction: float = position_x - enemy_position_x 
	if damage_direction > 0:
		player.last_damage_direction = 1
	else:
		player.last_damage_direction = -1

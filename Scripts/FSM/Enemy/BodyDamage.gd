class_name EnemyBody
extends Area2D

signal took_damage()
signal boss_dead()

@onready var damage_sound: AudioStreamPlayer2D = $"../FSM/Damage/DamageSound"
@onready var sprite: AnimatedSprite2D = $"../Sprite"

func _on_area_entered(area):
	if area.name == "Killer":
		get_parent().queue_free()
		return
	var enemy: Enemy = get_parent()
	var non_combat_states: Array = [
	"Move",
	"Idle",
	"Jump",
	"Fall",
	"Damage",
	"Parried"
	]
	var entity: CharacterBody2D = area.get_parent()
	var enemy_position_x: float = enemy.global_position.x
	var enemy_direction: float = enemy.direction
	var entity_position_x: float = entity.global_position.x
	var current_state: String = entity.get_node("FSM").current_state.name
	var player_state: String = entity.get_node("FSM").current_state.name
	var is_non_combat: bool
	for state in non_combat_states:
		if state == current_state:
			is_non_combat = true
			break
	if area.is_in_group("Player Sword") && player_state.contains("Attack") && entity is Player:
		if is_non_combat:
			check_damage_direction(enemy, enemy_position_x, entity_position_x)
			took_damage.emit()
		elif enemy_position_x < entity_position_x && enemy_direction < 0:
			check_damage_direction(enemy, enemy_position_x, entity_position_x)
			took_damage.emit()
		elif enemy_position_x > entity_position_x && enemy_direction > 0:
			check_damage_direction(enemy, enemy_position_x, entity_position_x)
			took_damage.emit()
		elif current_state == "Defend Low" && player_state == "Attack 2":
			check_damage_direction(enemy, enemy_position_x, entity_position_x)
			took_damage.emit()
		elif current_state == "Defend High" && player_state == "Attack 1":
			check_damage_direction(enemy, enemy_position_x, entity_position_x)
			took_damage.emit()
		elif current_state.contains("Attack") && player_state.contains("Attack"):
			check_damage_direction(enemy, enemy_position_x, entity_position_x)
			took_damage.emit()

func check_damage_direction(enemy: Enemy, position_x: float, enemy_position_x: float):
	var damage_direction: float =  position_x - enemy_position_x
	if damage_direction > 0:
		enemy.last_damage_direction = 1
	else:
		enemy.last_damage_direction = -1

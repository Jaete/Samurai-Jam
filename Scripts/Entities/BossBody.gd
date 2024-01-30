class_name BossBody
extends Area2D

signal took_damage()
signal boss_dead()

@onready var damage_sound: AudioStreamPlayer2D = $"../FSM/EnemyState/DamageSound"
@onready var sprite: AnimatedSprite2D = $"../Sprite"
@onready var boss_bar: TextureProgressBar = $"../Healthbar/Texture"

func _on_area_entered(area):
	if area.name == "Killer":
		get_parent().queue_free()
		return
	var boss: Boss = get_parent()
	var non_combat_states: Array = [
	"Move",
	"Idle",
	"Jump",
	"Fall",
	"Damage",
	"Parried"
	]
	var entity: CharacterBody2D = area.get_parent()
	var enemy_position_x: float = boss.global_position.x
	var enemy_direction: float = boss.direction
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
			check_damage_direction(boss, enemy_position_x, entity_position_x)
			take_damage(boss)
		elif enemy_position_x < entity_position_x && enemy_direction < 0:
			check_damage_direction(boss, enemy_position_x, entity_position_x)
			take_damage(boss)
		elif enemy_position_x > entity_position_x && enemy_direction > 0:
			check_damage_direction(boss, enemy_position_x, entity_position_x)
			take_damage(boss)
		elif current_state == "Defend Low" && player_state == "Attack 2":
			check_damage_direction(boss, enemy_position_x, entity_position_x)
			take_damage(boss)
		elif current_state == "Defend High" && player_state == "Attack 1":
			check_damage_direction(boss, enemy_position_x, entity_position_x)
			take_damage(boss)
		elif current_state.contains("Attack") && player_state.contains("Attack"):
			check_damage_direction(boss, enemy_position_x, entity_position_x)
			take_damage(boss)

func check_damage_direction(boss: Boss, position_x: float, enemy_position_x: float):
	var damage_direction: float =  position_x - enemy_position_x
	if damage_direction > 0:
		boss.last_damage_direction = 1
	else:
		boss.last_damage_direction = -1

func take_damage(boss: Boss):
		boss.hp -= 1
		boss_bar.set_value(boss.hp)
		damage_sound.play()
		var damage_timer = get_tree().create_timer(0.1, false, true)
		sprite.set_modulate(Color(214,0,252,0.3))
		await damage_timer.timeout
		sprite.set_modulate(Color(1,1,1,1))
		took_damage.emit()

func boss_should_die(boss: Boss):
	if boss.hp == 0:
		boss_dead.emit()

func _on_took_damage():
	var boss: Boss = get_parent()
	boss_should_die(boss)

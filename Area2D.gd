extends Area2D

@onready var player: Player = get_node("/root/Heroi")

var hit_count = 0

func _on_area_entered(area):
	print("AREA NAME:", area.name)
	var current_state = str(player.get_node("FSM").current_state)
	if area.name == "Sword" and current_state.contains("Attack"):
		handle_hit()

func handle_hit():
	get_parent().set_frame(hit_count)
	hit_count += 1
	
	if hit_count == 6:
		get_parent().queue_free()

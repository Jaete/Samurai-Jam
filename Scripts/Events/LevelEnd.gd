extends Area2D

@onready var player: Player = get_node("/root/Hero")
@onready var level_2 = load("res://level_2.tscn")

func _on_body_entered(body):
	if body is Player:
		if player.kill_count < 7:
			var current_state = player.get_node("FSM").current_state
			player.get_node("FSM").change_state(current_state, "Idle")
			player.get_node("FSM").set_physics_process(false)
			Dialogic.start("shall_not_pass")
			await Dialogic.timeline_ended
			player.velocity.x = 0
			player.get_node("FSM").set_physics_process(true)
		else:
			get_tree().change_scene_to_packed(level_2)

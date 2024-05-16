extends Node2D

@onready var boss = $".."

func _on_area_2d_body_entered(body):
	boss.get_node("FSM").set("current_state", BossMove)

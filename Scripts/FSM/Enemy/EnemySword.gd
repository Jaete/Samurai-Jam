class_name EnemySword
extends Area2D

signal parried()

func _on_area_entered(area):
	if area.is_in_group("Player Sword"):
		parried.emit()

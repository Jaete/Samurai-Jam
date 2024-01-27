extends Area2D

signal took_damage()

func _on_area_entered(area):
	if area.name == "Sword" && area.is_in_group("Player Sword"):
		took_damage.emit()

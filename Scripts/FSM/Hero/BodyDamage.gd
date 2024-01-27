extends Area2D

signal took_damage()

func _on_area_entered(area):
	if area.name == "Sword" && area.is_in_group("Enemy Sword"):
		took_damage.emit()

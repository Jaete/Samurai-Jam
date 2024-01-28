extends Area2D

signal took_damage()

func _on_area_entered(area):
	if area.is_in_group("Spikes"):
		took_damage.emit()
	
	if area.name == "Sword" && area.is_in_group("Enemy Sword"):
		took_damage.emit()
		

#func _on_area_exited(area):
	#pass

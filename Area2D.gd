extends Area2D

@onready var tilemap: TileMap = $".."
var current_cord: Vector2 = Vector2.ZERO

func _on_area_entered(area):
	print("AREA NAME:", area.name)
	if area.name == "Sword":
		handle_hit()

func handle_hit():
	current_cord = current_cord + Vector2(1,0) 
	print("TILEMAP:", current_cord)
	
	

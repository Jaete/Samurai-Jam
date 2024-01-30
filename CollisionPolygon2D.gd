extends Node2D

func _ready():
	# Cria um CollisionShape2D
	var collision_shape = CollisionShape2D.new()
	add_child(collision_shape)

	# Adiciona o CollisionPolygon2D principal
	var main_polygon = CollisionPolygon2D.new()
	main_polygon.polygon = [Vector2(0, 0), Vector2(100, 0), Vector2(100, 100), Vector2(0, 100)]
	collision_shape.add_child(main_polygon)

	# Adiciona o CollisionPolygon2D para o buraco
	var hole_polygon = CollisionPolygon2D.new()
	hole_polygon.polygon = [Vector2(20, 20), Vector2(80, 20), Vector2(80, 80), Vector2(20, 80)]
	hole_polygon.one_way_collision = true
	collision_shape.add_child(hole_polygon)

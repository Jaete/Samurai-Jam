extends Node2D

@export var offset = Vector2(-200, 0)
@export var duration = 5.0

func _ready():
	start_tween()

func start_tween():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position", offset, duration / 1)
	tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration / 1)

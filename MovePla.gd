extends PathFollow2D

var speed = 0.15
var epsilon = 0.001
var is_forward = true


func _physics_process(delta):
	if is_forward:
		progress_ratio += speed * delta
		if progress_ratio >= 1 - epsilon:
			is_forward = false
	if !is_forward:
		progress_ratio -= speed * delta
		if progress_ratio <= 0.0 + epsilon:
			is_forward = true

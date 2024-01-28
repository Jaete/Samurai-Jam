class_name Spikes
extends AnimatedSprite2D

func _ready():
	get_node("AnimationPlayer").play("Rise")

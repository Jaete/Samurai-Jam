extends Area2D

@onready var player: Player = get_node("/root/Hero")
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	audio.autoplay = true
	anim.play("default")

func _on_body_entered(body):
	if body is Player:
		player.gravity = player.gravity * 3
		player.fall_gravity = player.fall_gravity * 3
	pass # Replace with function body.

func _on_body_exited(body):
	if body is Player:
		player.gravity = player.gravity / 3
		player.fall_gravity = player.fall_gravity / 3
	pass # Replace with function body.

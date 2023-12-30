class_name AnimationHandler
extends Node2D

@onready var sprite: AnimatedSprite2D = $"../Sprite"
var direction = "Right"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_player_direction(player: Player):
	var velocity = player.velocity.x
	if velocity < 0:
		direction = "Left"
	if velocity > 0:
		direction = "Right"
	if velocity == 0:
		direction = direction
	return direction

func play_animation(player: Player, state: String):
	get_player_direction(player)
	var anim = state
	match direction:
		"Left":
			sprite.flip_h = true
		"Right":
			sprite.flip_h = false
	if sprite.get_animation() != anim:
		sprite.play(anim)

class_name AnimationHandler
extends Node2D

var direction = "Right"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_player_direction(player: Player):
	if player.direction < 0:
		direction = "Left"
	if player.direction > 0:
		direction = "Right"
	if player.direction == 0:
		direction = direction
	return direction

func play_animation(player: Player, state: String, animation: AnimationPlayer, sprite: AnimatedSprite2D):
	get_player_direction(player)
	var anim = state
	match direction:
		"Left":
			sprite.flip_h = true
		"Right":
			sprite.flip_h = false
	if animation.current_animation != anim:
		if state.contains("Idle") or state.contains("Move"):
			animation.play(anim)
		else:
			animation.play(anim +" "+direction)
			

func is_animation_finished(animation: AnimationPlayer):
	return true if animation.current_animation_length == animation.current_animation_position else false

func get_animation_position(animation: AnimationPlayer):
	return animation.current_animation_position

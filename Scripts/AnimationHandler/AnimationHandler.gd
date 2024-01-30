class_name AnimationHandler
extends Node2D

var direction = "Right"

func get_entity_direction(entity: CharacterBody2D):
	if entity.direction < 0:
		direction = "Left"
	if entity.direction > 0:
		direction = "Right"
	if entity.direction == 0:
		direction = direction
	return direction

func play_animation(entity: CharacterBody2D, state: String, animation: AnimationPlayer, sprite: AnimatedSprite2D, is_boss: bool = false):
	get_entity_direction(entity)
	var anim = state
	if !is_boss:
		match direction:
			"Left":
				sprite.flip_h = true
			"Right":
				sprite.flip_h = false
	if animation.current_animation != anim:
		if (state.contains("Idle") || state.contains("Move")) && !is_boss:
			animation.play(anim)
		else:
			animation.play(anim +" "+direction)
			

func is_animation_finished(animation: AnimationPlayer):
	return true if animation.current_animation_length == animation.current_animation_position else false

func get_animation_position(animation: AnimationPlayer):
	return animation.current_animation_position

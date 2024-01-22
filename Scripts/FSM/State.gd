class_name State
extends Node2D

signal state_transition()
signal unsheath()
signal sheath()

@onready var animation: AnimationPlayer = $"../../Sprite/AnimationPlayer"
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../Sprite"
@onready var animation_handler: AnimationHandler = $"../AnimationHandler"
@onready var left_collisor: RayCast2D = $"../../Body/Left Collisor" 
@onready var right_collisor: RayCast2D = $"../../Body/Right Collisor" 

var already_running: bool = false

func _init():
	#sheated = true
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

func change_state(_new_state: String) -> void:
	state_transition.emit(self,_new_state)
	pass

func perform_state_action(_delta: float) -> void:
	pass

func should_play_sheated_animation():
	if player.sheated:
		animation_handler.play_animation(player, self.name, animation, sprite)
	else:
		animation_handler.play_animation(player, self.name + " Sword", animation, sprite)
	pass

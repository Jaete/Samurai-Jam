class_name State
extends Node2D

signal state_transition()

@onready var animation: AnimationPlayer = $"../../Sprite/AnimationPlayer"
@onready var player: Player = get_node("/root/Hero")
@onready var sprite: AnimatedSprite2D = $"../../Sprite"
@onready var animation_handler: AnimationHandler = $"../AnimationHandler"
@onready var left_collisor: RayCast2D = $"../../BodyCollisor/Left Collisor" 
@onready var right_collisor: RayCast2D = $"../../BodyCollisor/Right Collisor" 

var already_running: bool = false

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
	
func _on_body_took_damage():
	change_state("Damage")

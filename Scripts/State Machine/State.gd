class_name State
extends Node2D

signal state_transition()

@onready var sprite: AnimatedSprite2D = $"../../Sprite"
@onready var player: Player = $"../.."
@onready var animation_handler: AnimationHandler = $"../../AnimationHandler"

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
	pass

func perform_state_action():
	pass

class_name State
extends Node2D

signal state_transition()

@onready var sprite: AnimatedSprite2D = $"../../Sprite"
@onready var player: Player = $"../.."
@onready var animation_handler: AnimationHandler = $"../../AnimationHandler"

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

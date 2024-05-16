extends Node2D

@onready var button = $CanvasLayer/Button
@onready var level_1 = preload("res://level_1.tscn")

func _ready():
	get_node("/root/Healthbar").set_visible(false)

func _on_button_pressed():
	get_tree().change_scene_to_packed(level_1)

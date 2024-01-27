extends StaticBody2D

var tween: Tween
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready():
	animation.play("Move")

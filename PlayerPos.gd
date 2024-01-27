extends RichTextLabel

@onready var player: Player = $".."
@onready var animh: AnimationHandler = $"../FSM/AnimationHandler"

func _physics_process(_delta):
	var string3: String = str(player.velocity.x)
	var string4: String = animh.direction
	set_text("\n Player Velocity X: " + string3 + "\n Player Direction: " + string4)

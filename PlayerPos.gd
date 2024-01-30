extends RichTextLabel

@onready var player: Player = $".."
@onready var animh: AnimationHandler = $"../FSM/AnimationHandler"
@onready var boss = get_node("/root/Main/Boss")

func _physics_process(_delta):
	pass
	#var string3: String = str(player.velocity.x)
	#var string4: String = str(abs(player.global_position.x - boss.global_position.x))
	#set_text("Player Velocity X: " + string3 + "\n Player Distance: " + string4)

extends Label

@onready var player: Player = $".."
@onready var animh: AnimationHandler = $"../FSM/AnimationHandler"

func _physics_process(_delta):
	var string3: String = str(player.kill_count)
	var string4: String = player.get_node("FSM").current_state.name
	set_text("\n State: " + string4)

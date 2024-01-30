extends RichTextLabel

@onready var enemy: Enemy = $".."

func _physics_process(_delta):
	var string: String = str(enemy.get_node("FSM").current_state)
	set_text("State: " + string)

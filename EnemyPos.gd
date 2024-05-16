extends Label

@onready var enemy: Enemy = $".."

func _physics_process(_delta):
	var string: String = str(enemy.get_node("FSM").current_state.name)
	var string2: String = str(enemy.sequential_hits)
	set_text("State: " + string + "\nSeq. Hits: " + string2)

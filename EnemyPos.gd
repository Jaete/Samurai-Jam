extends RichTextLabel

@onready var boss: Boss = $".."
@onready var animh: AnimationHandler = $"../FSM/AnimationHandler"

func _physics_process(_delta):
	var string: String = str(boss.hp)
	var string2: String = str(boss.get_node("FSM").current_state.name)
	var string3: String = str(boss.direction)
	set_text("HP: " + string + "\nState: " + string2 + "\nDirection: " + string3)

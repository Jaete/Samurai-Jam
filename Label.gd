extends Label

func _physics_process(delta):
	var t1: String = str(get_parent().direction)
	set_text("Direction: " + t1)

extends AnimationPlayer

@onready var player = get_node("/root/Hero")

func _enter_tree():
	play("Charge")

func _physics_process(_delta):
	if current_animation == "Charge":
		get_parent().get_parent().global_position.x = player.global_position.x + 5
		get_parent().get_parent().global_position.y = player.global_position.y - 45
	if current_animation == "Unleash":
		set_physics_process(false)
		pass

func _on_animation_finished(anim_name):
	if anim_name == "Charge":
		set_physics_process(false)
		play("Unleash")
	if anim_name == "Unleash":
		set_physics_process(true)
		get_parent().get_parent().queue_free()

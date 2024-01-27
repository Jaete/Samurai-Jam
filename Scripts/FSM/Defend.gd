class_name Defend
extends State

var defense_direction: String = ""

func enter() -> void:
	check_defense_direction()
	animation_handler.play_animation(player, self.name + defense_direction, animation, sprite)	
	pass

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	check_defense_direction()
	should_change_state()
	pass

func should_change_state() -> void:
	if Input.is_action_just_pressed("Jump"):
		change_state("Jump")
	if Input.is_action_just_pressed("Attack"):
		change_state("Attack 1")
	if Input.get_axis("Move_Left","Move_Right"):
		change_state("Move")
	if !Input.is_anything_pressed():
		change_state("Sheath")
	pass

func check_defense_direction() -> void:
	if Input.is_physical_key_pressed(KEY_UP):
		if defense_direction != " High":
			defense_direction = " High"
			animation_handler.play_animation(player, self.name + defense_direction, animation, sprite)	
	if Input.is_physical_key_pressed(KEY_DOWN):
		if defense_direction != " Low":
			defense_direction = " Low"
			animation_handler.play_animation(player, self.name + defense_direction, animation, sprite)	

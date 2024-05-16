class_name BossIdle
extends BossState

var idle_time: SceneTreeTimer

func enter():
	boss.velocity.x = 0
	animation_handler.play_animation(boss, self.name, animation, sprite, true)
	idle_time = get_tree().create_timer(1, false, true)
	pass

func exit():
	pass

func update(_delta: float):
	set_direction()
	should_change_state()
	pass

func should_change_state():
	if !player.is_dead:
		if Input.is_action_just_pressed("debug_trigger_boss"):
			if !boss_health.is_visible():
				boss_health.set_visible(true)
			boss.boss_triggered = true
			change_state("Move")
		if boss.boss_triggered:
			change_state("Move")
		if !boss.is_on_floor():
			change_state("Fall")
	pass

func set_direction():
	if boss.velocity.x > 0:
		boss.direction = 1
	elif boss.velocity.x < 0:
		boss.direction = -1
	else:
		boss.direction = boss.direction

func _on_area_2d_body_entered(body):
	change_state("Move")

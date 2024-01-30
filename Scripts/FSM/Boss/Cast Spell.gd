class_name BossCastSpell
extends BossState

signal spell_casted()

func enter() -> void:
	animation_handler.play_animation(boss, self.name, animation, sprite, true)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func should_change_state() -> void:
	pass

func _on_boss_animation_finished(anim_name):
	if anim_name == self.name + " Left" || anim_name == self.name + " Right":
		var spell = preload("res://Objects/spell_area.tscn").instantiate()
		get_node("/root/Main").add_child(spell)
		change_state("Move")

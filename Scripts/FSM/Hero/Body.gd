class_name Body
extends CollisionShape2D

signal enemy_damage_dealt()

func _on_body_damage_body_entered(body):
	if body.is_in_group("Enemy Sword"):
		enemy_damage_dealt.emit()

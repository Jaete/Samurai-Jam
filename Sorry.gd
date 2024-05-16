extends Area2D

var trigger_once: bool = false

func _on_body_entered(body):
	if !trigger_once:
		if body is Player:
			Dialogic.start("sorry")
			await Dialogic.timeline_ended
			trigger_once = true

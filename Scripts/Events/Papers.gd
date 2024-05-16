extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if Dialogic.current_timeline != null:
		return
	Dialogic.start('paper_read')
	get_viewport().set_input_as_handled()

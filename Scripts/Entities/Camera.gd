extends Camera2D

@onready var player: Player =  get_node("/root/Heroi")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	self.position = player.position
	pass

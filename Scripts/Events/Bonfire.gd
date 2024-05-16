extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var bonfire_sound: AudioStreamPlayer = $"Bonfire Heal"
@onready var bgm: AudioStreamPlayer = get_node("/root/Bgm")

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	var player: Player = get_node("/root/Hero")
	var health_bar: TextureProgressBar = get_node("/root/Healthbar/Texture")
	player.health = player.max_health
	health_bar.set_value(player.health)
	var anim: AnimationPlayer = player.get_node("Sprite").get_node("AnimationPlayer")
	player.set_physics_process(false)
	anim.play("Rest")
	bgm.set_stream_paused(true)
	bonfire_sound.play()
	await bonfire_sound.finished
	bgm.set_stream_paused(false)
	player.set_physics_process(true)
	

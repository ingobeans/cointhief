extends AnimatedSprite2D

@onready var audio_player = $AudioStreamPlayer
var taken = false
var pitch_variation = 0.4

func _ready() -> void:
	audio_player.pitch_scale = 1.0 + randf()*pitch_variation-pitch_variation/2.0

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if !taken:
		audio_player.play()
		visible = false
		taken = true
	

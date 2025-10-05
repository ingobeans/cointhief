extends AnimatedSprite2D

@onready var audio_player = $AudioStreamPlayer
var pitch_variation = 0.2
var force = 600
var player_jumped = false

func _process(_delta: float) -> void:
	var bodies = $Area2D.get_overlapping_bodies()
	if len(bodies) == 0:
		player_jumped = false
	elif !player_jumped:
		if Input.is_action_just_pressed("jump"):
			player_jumped = true
			audio_player.pitch_scale = 1.0 + randf()*pitch_variation-pitch_variation/2.0
			audio_player.play()
			print("jump!")
			bodies[0].velocity.y -= force
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.on_launchpad = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	body.on_launchpad = false

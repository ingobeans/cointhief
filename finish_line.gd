extends Node2D

@export var next_level: PackedScene
var should_load_next = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	# because loading the scene here causes a crash,
	# since "removing a collisionobject node during a physics callback is not allowed"
	should_load_next = true

func _process(delta: float) -> void:
	if should_load_next:
		get_parent().get_parent().change_scene(next_level)

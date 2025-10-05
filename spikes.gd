extends Area2D

func _process(_delta: float) -> void:
	if len(get_overlapping_bodies()) > 0:
		get_parent().get_parent().restart_level()

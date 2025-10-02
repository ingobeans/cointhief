extends Node2D

@onready var first_level = preload("res://level_1.tscn")

func  _ready() -> void:
	add_child(first_level.instantiate())

func change_scene(scene: PackedScene):
	get_child(0).queue_free()
	add_child(scene.instantiate())

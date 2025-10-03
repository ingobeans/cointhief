extends Node2D

@onready var ui = self.get_node("../CanvasLayer")

func return_to_menu():
	get_child(0).queue_free()
	ui.visible = true
	

func change_scene(scene: PackedScene):
	var c = get_child(0)
	if c != null:
		c.queue_free()
	add_child(scene.instantiate())
	ui.visible = false

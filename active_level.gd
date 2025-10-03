extends Node2D

@onready var ui = self.get_node("../MainMenuLayer")
@onready var pause_menu = self.get_node("../PauseMenu")

func return_to_menu():
	get_child(0).queue_free()
	ui.visible = true
	
func _process(delta: float) -> void:
	if !ui.visible:
		if Input.is_action_just_pressed("pause"):
			pause_menu.visible = !pause_menu.visible

func change_scene(scene: PackedScene):
	var c = get_child(0)
	if c != null:
		c.queue_free()
	add_child(scene.instantiate())
	ui.visible = false

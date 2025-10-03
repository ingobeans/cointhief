extends Node2D

@onready var ui = self.get_node("../MainMenuLayer")
@onready var pause_menu = self.get_node("../PauseMenu")
@onready var options_menu = self.get_node("../Options")

func return_to_menu():
	get_child(0).queue_free()
	ui.visible = true
	
func _process(_delta: float) -> void:
	if !ui.visible:
		if Input.is_action_just_pressed("pause"):
			if options_menu.visible:
				options_menu.visible = false
			else:
				pause_menu.visible = !pause_menu.visible

func change_scene(scene: PackedScene):
	var c = get_child(0)
	if c != null:
		c.queue_free()
	add_child(scene.instantiate())
	ui.visible = false

extends Node2D

@onready var ui = self.get_node("../MainMenuLayer")
@onready var pause_menu = self.get_node("../PauseMenu")
@onready var options_menu = self.get_node("../Options")

func restart_level():
	var level_id = get_child(0).name.trim_prefix("Level")
	var level_name = "level_" + level_id
	var path = "res://" + level_name + ".tscn"
	change_scene(load(path))

func return_to_menu():
	get_child(0).queue_free()
	ui.visible = true
	
func _process(_delta: float) -> void:
	if !ui.visible:
		if Input.is_action_just_pressed("restart"):
			restart_level()
		if Input.is_action_just_pressed("pause"):
			if options_menu.visible:
				options_menu.visible = false
			else:
				pause_menu.visible = !pause_menu.visible

func change_scene(scene: PackedScene):
	var c = get_child(0)
	if c != null:
		c.name = "deletedscene"
		c.queue_free()
	add_child(scene.instantiate(),true)
	ui.visible = false

extends Node2D

@onready var ui = self.get_node("../MainMenuLayer")
@onready var pause_menu = self.get_node("../PauseMenu")
@onready var options_menu = self.get_node("../Options")
@onready var level_complete_screen = self.get_node("../LevelCompleteScreen")

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
	
func restart_level():
	var level_id = get_child(0).name.trim_prefix("Level")
	var level_name = "level_" + level_id
	var path = "res://" + level_name + ".tscn"
	change_scene(load(path))

func return_to_menu(time: float, coins: int, coins_max: int, new_best: bool):
	var c = get_child(0)
	
	ui.visible = true
	level_complete_screen.visible = true
	var time_text = str(round_to_dec(time / 1000,2))
	if new_best:
		time_text += " (New best!)"
	else:
		var best = config.config.get_value("levels",c.name.trim_prefix("Level"))
		time_text += " (Best: " + str(round_to_dec(best["time"] / 1000,2)) + ")"
	
	level_complete_screen.get_node("Time").text = time_text
	level_complete_screen.get_node("Coins").text = str(coins) + "/" + str(coins_max)
	
	c.queue_free()
	
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

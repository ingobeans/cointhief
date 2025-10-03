extends Button

@onready var active_level = self.get_node("../../../ActiveLevel")

func _pressed() -> void:
	var level_name = "level_" + name
	var path = "res://" + level_name + ".tscn"
	active_level.change_scene(load(path))
	

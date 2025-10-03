extends Button

@onready var active_level = self.get_node("../../../ActiveLevel")

func reload_state():
	if name == "1":
		return
	var prev_level = str(int(name) - 1)
	var value = config.config.get_value("levels",prev_level,"no")
	disabled = value != "completed"
		

func _ready() -> void:
	reload_state()
	visibility_changed.connect(reload_state)

func _pressed() -> void:
	var level_name = "level_" + name
	var path = "res://" + level_name + ".tscn"
	active_level.change_scene(load(path))
	

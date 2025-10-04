extends Button

@onready var active_level = self.get_node("../../ActiveLevel")

func _pressed() -> void:
	active_level.restart_level()
	get_parent().visible = false

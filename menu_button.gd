extends Button

@export var menu_to_load: Node
@onready var parent = self.get_parent()

func _pressed() -> void:
	menu_to_load.visible = true
	parent.visible = false

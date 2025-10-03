extends Button

@export var loads: Array[Node]
@export var unloads: Array[Node]

func _pressed() -> void:
	for i in loads:
		i.visible = true
	for i in unloads:
		i.visible = false

extends Path2D

@onready var coin = preload("res://coin.tscn").instantiate()

func _ready() -> void:
	for point_index in range(curve.point_count):
		var child = coin.duplicate()
		child.position = curve.get_point_position(point_index)
		add_child(child)

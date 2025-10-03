extends Node2D

var should_return_to_menu = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	# because loading the scene here causes a crash,
	# since "removing a collisionobject node during a physics callback is not allowed"
	should_return_to_menu = true

func _process(_delta: float) -> void:
	if should_return_to_menu:
		var level_name = get_parent().get_parent().get_child(0).name.trim_prefix("Level")
		config.config.set_value("levels",level_name,"completed")
		config.save()
		get_parent().get_parent().return_to_menu()

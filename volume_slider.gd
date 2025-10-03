extends HSlider

func _ready() -> void:
	value = config.config.get_value("options","volume")
	AudioServer.set_bus_volume_linear(0,value/50.0)

func _on_drag_ended(_value_changed: bool) -> void:
	config.config.set_value("options","volume",value)
	AudioServer.set_bus_volume_linear(0,value/50.0)
	$AudioStreamPlayer.play()
	config.save()

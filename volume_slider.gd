extends HSlider

func _ready() -> void:
	value = config.config.get_value("options","volume")
	AudioServer.set_bus_volume_linear(0,value)

func _value_changed(new_value: float) -> void:
	config.config.set_value("options","volume",new_value)
	AudioServer.set_bus_volume_linear(0,new_value/50.0)
	config.save()

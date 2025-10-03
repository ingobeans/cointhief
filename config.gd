extends Node

var config: ConfigFile

func _init() -> void:
	config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	if err:
		config.set_value("options","volume",25.0)

func save():
	config.save("user://config.cfg")

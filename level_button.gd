extends Button

@onready var active_level = self.get_node("../../../ActiveLevel")

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func reload_state():
	var current_level_stats = config.config.get_value("levels",name)
	$Stats.visible = current_level_stats != null
	if current_level_stats != null:
		$Stats/Coins.text = str(current_level_stats["coins"]) + "/" + str(current_level_stats["max_coins"])
		$Stats/Time.text = str(round_to_dec(current_level_stats["time"] / 1000,2))
	
	if name == "1":
		return
	var prev_level = str(int(name) - 1)
	var value = config.config.get_value("levels",prev_level)
	disabled = value == null
		

func _ready() -> void:
	reload_state()
	visibility_changed.connect(reload_state)

func _pressed() -> void:
	var level_name = "level_" + name
	var path = "res://" + level_name + ".tscn"
	active_level.change_scene(load(path))
	

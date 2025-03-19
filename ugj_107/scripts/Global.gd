extends Node

var levels = ["res://scenes/city_sprawl.tscn", #Level One
"res://scenes/level_two.tscn", #Level Two
"res://scenes/main_menu.tscn"
]

var index = 0

func _onready():
	get_tree().change_scene_to_file(levels[index])

func _on_player_next_level() -> void:
	index += 1
	get_tree().change_scene_to_file(levels[index])

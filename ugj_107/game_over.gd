extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_back_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Touched")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

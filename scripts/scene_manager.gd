extends Node

var last_scene_path = ""

func set_last_scene(path: String) -> void:
	last_scene_path = path
	print(last_scene_path)

func get_last_scene() -> String:
	return last_scene_path

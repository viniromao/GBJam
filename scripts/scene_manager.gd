extends Node

var last_scene_path = ""

func set_last_scene(path: String) -> void:
	last_scene_path = path

func get_last_scene() -> String:
	audio_manager.play_music()
	return last_scene_path

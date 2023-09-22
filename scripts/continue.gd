extends Control

var seconds = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_timer()
	
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		print(scene_manager.get_last_scene())
		get_tree().change_scene_to_file(scene_manager.get_last_scene())

func _on_timer_timeout():
	if seconds == 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		$number.text = str(seconds)
		seconds -= 1

func reset_timer():
	seconds = 10
	$number.text = str(seconds)  # Set the initial text to 10 when resetting

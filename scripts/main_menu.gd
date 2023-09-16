extends Node2D

var anim: AnimationPlayer

func _ready():
	pass
	#anim = $AnimationPlayer  # Replace with the actual path to your AnimationPlayer nodes.

	# Start the animations with a delay of 0.5 seconds
	#$Timer.start(0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		_on_button_pressed()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# Called when the Timer times out (after 0.5 seconds)
#func _on_timer_timeout():
	#anim.play("descending")
	get_tree().change_scene_to_file("res://scenes/first_cut_scene.tscn")

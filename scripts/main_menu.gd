extends Node2D

# Declare a variable to store the AnimationPlayer node
@onready var animation_player = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	# Play the "descending" animation
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func call_first_scene():
	get_tree().change_scene_to_file("res://scenes/first_cut_scene.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):  
		call_first_scene()
		
func _on_blink_timeout():
	$start.visible = not $start.visible

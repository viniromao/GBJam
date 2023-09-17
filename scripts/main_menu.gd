extends Node2D

# Declare a variable to store the AnimationPlayer node
@onready var animation_player = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	# Play the "descending" animation
	animation_player.play("descending")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		_on_button_pressed()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

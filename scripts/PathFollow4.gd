extends PathFollow2D

@export var runSpeed = .2

var follower = preload("res://actors/enemy4.tscn")

func _ready():
	var newFollower = follower.instantiate()
	add_child(newFollower)

func _process(delta):
	set_progress_ratio(get_progress_ratio() + runSpeed * delta)


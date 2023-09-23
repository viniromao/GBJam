extends Sprite2D

var rotation_speed = 2  # Degrees per frame

func _process(delta):
	rotation_degrees += rotation_speed

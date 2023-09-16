extends Sprite2D

# Speed of the background scroll
@export var scroll_speed = 100.0

# Store the initial position to reset it later
var initial_position

func _ready():
	initial_position = position

func _process(delta):
	position.x -= scroll_speed * delta

	if position.x <= -texture.get_width():
		position.x = initial_position.x

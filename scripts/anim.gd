extends AnimationPlayer

@onready var title = $Title
@onready var title2 = $Title2
@onready var title3 = $Title3
@onready var title4 = $Title4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	title.global_position = get_global_mouse_position()
	title2.global_position = title2.global_position.linear_interpolate(title.global_position, .3)
	title3.global_position = title3.global_position.linear_interpolate(title2.global_position, .3)
	title4.global_position = title4.global_position.linear_interpolate(title3.global_position, .3)

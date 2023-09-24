extends PathFollow2D

@export var runSpeed = .2
var follower = null 
var delete_on_finish = true 

func set_follower(scene_path):
	follower = load(scene_path)
	var boss_instance = follower.instantiate()
	add_child(boss_instance)
	
func set_delete_on_finish(delete):
	delete_on_finish = delete

func _ready():
	if follower:
		var newFollower = follower.instantiate()
		add_child(newFollower)

func _process(delta):
	set_progress_ratio(get_progress_ratio() + runSpeed * delta)
	if get_progress_ratio() >= 1.0 && delete_on_finish:
		queue_free()

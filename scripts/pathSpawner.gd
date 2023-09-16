extends Path2D

var timer = 0
@export var spawnTime = .5

var path

func _ready():
	var newPath = path.instantiate()
	add_child(newPath)

func _process(delta):
	timer += delta
	if (timer > spawnTime):
		var pathInstance = path.instantiate()
		add_child(pathInstance)
		timer = 0

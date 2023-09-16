class_name Enemy extends Area2D

@export var speed = 20

func _physics_process(delta):
	global_position.x += -speed * delta

func die():
	queue_free()

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		body.die()
		die()

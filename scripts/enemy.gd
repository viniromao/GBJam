class_name Enemy5 extends Area2D

@export var speed = 150
@export var damage = 1

func die():
	queue_free()

func _physics_process(delta):
	global_position.y += speed * delta  # Note that it's y instead of x for top-down shooting

func _ready():
	pass # 


func _process(delta):
	pass

func _on_body_entered(body):
	if body is Player:
		if body.invincible:
			return
		body.take_damage()
		die()


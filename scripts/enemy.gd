class_name Enemy extends Area2D

func die():
	queue_free()

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


func _on_area_entered(area):
	pass

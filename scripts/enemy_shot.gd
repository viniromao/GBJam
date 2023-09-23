extends Area2D

@export var speed = 150
@export var damage = 1

var direction = Vector2(1, 0)  # Default direction

func set_direction(new_direction):
	direction = new_direction.normalized()
	$Sprite2D.rotation = direction.angle()
	
func set_speed(new_speed):
	speed = new_speed

func _physics_process(delta):
	global_position += direction * speed * delta


func die():
	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	
func _on_body_entered(body):
	if body is Player:
		if body.invincible:
			return
		body.take_damage()
		die()
		
		
func _on_area_entered(area):
	die()

class_name Laser extends Area2D

@export var speed = 150
@export var damage = 1
@export var direction = Vector2(1, 0)  

func _ready():
	direction = direction.normalized()

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_area_entered(area):
	if area is Player:
		area.die()
		queue_free()
		
	if area is Enemy5:
		area.die()
		queue_free()
		
	if area is Enemy3:
		area.die()
		queue_free()
		
#	if area is Enemy4:
#		area.die()
#		queue_free()
		
	if area is Boss:
		area.take_damage()
		queue_free()
		
	var root_script = get_tree().current_scene
	if root_script:
		root_script.increase_score(20)

	queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	# Remove the shot if it goes off-screen
	queue_free()


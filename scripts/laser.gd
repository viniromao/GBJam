extends Area2D

@export var speed = 150
@export var damage = 1

func _physics_process(delta):
	global_position.x += speed * delta

func _on_area_entered(area):
	if area is Enemy:
		area.die()
		queue_free()
		
		if area.name == "MainArea":
			emit_signal("score_increased", 20)	
		elif area.name == "Level2Area":
			emit_signal("score_increased", 20)

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


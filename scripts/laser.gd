extends Area2D

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

		var main_script = get_tree().get_root().get_node("Main")  # Assuming the main node's name is "Main"
		main_script.increase_score(20)

		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	# Remove the shot if it goes off-screen
	queue_free()

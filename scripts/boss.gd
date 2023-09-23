class_name Boss extends Area2D

@export var life = 5
@export var num_shots = 10  # The number of shots to fire in a circle
@export var shot_speed = 30
@export var shot = preload("res://actors/enemy_shot.tscn")  # Replace with the actual path to your enemy_shot.tscn

func take_damage():
	var animation_player = $anim
	animation_player.play("damage")
	life -= 1
	if (life <= 0):
		die()

func die():
	var animation_player = $anim
	animation_player.play("damage")
	await animation_player.animation_finished
	queue_free()

func _on_body_entered(body):
	if body is Player:
		if body.invincible:
			return
		body.take_damage()
		die()

func _on_shoot_timeout():
	shoot_in_circle()


func shoot_in_circle():
	for i in range(num_shots):
		var angle_deg = i * (360 / num_shots)
		var angle_rad = deg_to_rad(angle_deg)

		var direction = Vector2(cos(angle_rad), sin(angle_rad))

		var shot_instance = shot.instantiate()
		
		shot_instance.global_position = $Sprite2D.global_position
		shot_instance.set_direction(direction * shot_speed)
		shot_instance.set_speed(shot_speed)

		get_tree().current_scene.add_child(shot_instance) 

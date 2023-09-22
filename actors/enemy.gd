class_name Enemy extends Area2D

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

class_name Boss extends Area2D

@export var life = 100

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

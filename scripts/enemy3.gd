class_name Enemy3 extends Area2D

var shot = preload("res://actors/enemy_shot.tscn")
var canShoot = true
var nextShootTime = 0

func die():
	var animation_player = $anim
	animation_player.play("damage")
	await animation_player.animation_finished
	queue_free()

func shoot():
	if canShoot:
		var newShot = shot.instantiate()
		get_tree().current_scene.add_child(newShot)
		newShot.global_position = self.global_position 
		
		var viewport_size = get_viewport().get_visible_rect().size
		if global_position.y < viewport_size.y / 2:
			newShot.speed = -40 
		else:
			newShot.speed = 40 

		canShoot = false
		var timer = get_tree().create_timer(1.0)  # Cooldown timer
		await timer.timeout
		canShoot = true


func _ready():
	nextShootTime = randf() * 5 + 1 # Randomly set the first shoot time between 1 to 6 seconds

func _process(delta):
	nextShootTime -= delta # Reduce the time until the next shot
	if nextShootTime <= 0:
		shoot()
		nextShootTime = randf() * 5 + 1 # Reset the timer to a new random value

func _on_body_entered(body):
	if body is Player:
		if body.invincible:
			return
		body.take_damage()
		die()

class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal killed

@export var speed = 100
@export var rate_of_fire := 0.25
@export var lives := 3
@export var invincible = false

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/laser.tscn")

var shoot_cd := false

func _on_flicker_timeout():
	$Texture.visible = not $Texture.visible
	
func _ready():
	var flicker = get_node("flicker")	
	flicker.timeout.connect(_on_flicker_timeout)

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	velocity = direction * speed
	move_and_slide()

	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)

func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)

func take_damage():
	if invincible: 
		return
	lives -= 1
	var script = get_tree().current_scene
	script.decrease_lives()
	if (lives <= 0):
		die()
	else:
		set_invincible()
		
func set_invincible():
	if invincible:
		return
	
	invincible = true
#	$invincible.start()
	$flicker.start(.05)
	
	var timer = get_tree().create_timer(3)
	await timer.timeout
	invincible = false
	$flicker.stop()
	$Texture.visible = true
	

func die():
	killed.emit()
	queue_free()

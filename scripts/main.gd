extends Node2D

@onready var spawn_player_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var gos = $UILayer/GameOver

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = spawn_player_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	
func _on_player_killed():
	await get_tree().create_timer(0.5).timeout
	gos.visible = true

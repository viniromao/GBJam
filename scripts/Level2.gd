extends Node2D

@onready var spawn_player_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer

@export var player_initial_position = Vector2(0,0)
@export var scroll_speed = 20.0

@export var spawnTime = .2
@export var spawnTime2 = .4
@export var spawnTime3 = .8
var spawnTimer = 0
var spawnTimer2 = 0
var mainTimer = 0

var score = 0
var lives = 3

var pathMapping = {
	1: preload("res://paths/path1.tscn"),  # First timer calls path5
	2: preload("res://paths/path2.tscn"),  # Second timer calls path3
	3: preload("res://paths/path3.tscn"),  # Third timer calls path1
	4: preload("res://paths/path4.tscn"),  # Fourth timer calls path2
	5: preload("res://paths/path5.tscn"), # Fourth timer also calls path10
	6: preload("res://paths/path6.tscn"),  # Fourth timer also calls path11
	7: preload("res://paths/path7.tscn"),  # Fourth timer also calls path11
	8: preload("res://paths/path8.tscn"),  # Fourth timer also calls path11
	9: preload("res://paths/path9.tscn"),  # Fourth timer also calls path11
	10: preload("res://paths/path10.tscn"), # Fourth timer also calls path11
	11: preload("res://paths/path11.tscn"), # Fourth timer also calls path11
	12: preload("res://paths/path12.tscn"), # Fourth timer also calls path11
	13: preload("res://paths/path13.tscn"), # Fourth timer also calls path11
}
var enemy_scene = preload("res://actors/enemy.tscn")

var player = null

func pad_with_zeros(number, width):
	var str_num = str(number)
	while str_num.length() < width:
		str_num = "0" + str_num
	return str_num

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = spawn_player_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)

func _process(delta):
	mainTimer += delta
	
	var padded_score = pad_with_zeros(score, 8) 
	$score.text = "scr: " + padded_score
	var padded_lives = pad_with_zeros(lives, 2) 
	$lives.text = "<" + padded_lives
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	spawnThings(delta)
		
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	
func spawnThings(delta):
	spawnTimer += delta
	spawnTimer2 += delta

	if spawnTimer > spawnTime3 && mainTimer < 6:
		spawnPath(1)
		spawnTimer = .1

	if spawnTimer > spawnTime3 && mainTimer >= 5 && mainTimer < 20:
		spawnPath(5) 
		spawnPath(7)
		spawnTimer = 0
		spawnTimer2 = 0

	if spawnTimer2 > spawnTime3 && mainTimer >= 20 && mainTimer < 30:
		spawnPath(3)
		spawnTimer2 = 0

	if spawnTimer2 > spawnTime3 && mainTimer >= 30 && mainTimer < 40:
		spawnPath(6)
		spawnTimer = 0
		spawnTimer2 = 0

	if spawnTimer2 > spawnTime3 && mainTimer >= 40 && mainTimer < 50:
		spawnPath(11) 
		spawnPath(12)
		spawnTimer = 0
		spawnTimer2 = 0 

	if spawnTimer2 > spawnTime3 && mainTimer >= 46 && mainTimer < 50:
		spawnPath(13)
		spawnPath(8)
		spawnTimer = 0
		spawnTimer2 = 0 

	if spawnTimer2 > spawnTime3 && mainTimer >= 50 && mainTimer < 60:
		spawnPath(10) 
		spawnPath(2) 
		spawnTimer = 0
		spawnTimer2 = 0 


	if spawnTimer > spawnTime3 && mainTimer < 60:
		pass
#		get_tree().change_scene_to_file("res://scenes/firstCutScene.tscn")

func spawnPath(index):
	var pathInstance = pathMapping[index].instantiate()
	add_child(pathInstance)

func increase_score(value):
	score += value
	
func decrease_lives():
	lives -= 1

func _on_player_killed():
	pass
#	await get_tree().create_timer(0.5).timeout
#	get_tree().change_scene_to_file("res://scenes/continue.tscn")
	

extends Node2D

@onready var spawn_player_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer

func pad_with_zeros(number, width):
	var str_num = str(number)
	while str_num.length() < width:
		str_num = "0" + str_num
	return str_num

var score = 0
var lives = 3

var timer = 0
@export var spawnTime = .5

var path1 = preload("res://paths/path1.tscn")
var path2 = preload("res://paths/path2.tscn")
var path3 = preload("res://paths/path3.tscn")
var enemy_scene = preload("res://actors/enemy.tscn")

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = spawn_player_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)

func _process(delta):
	var padded_score = pad_with_zeros(score, 8) 
	$score.text = "scr: " + padded_score
	var padded_lives = pad_with_zeros(lives, 2) 
	$lives.text = "<" + padded_lives
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	spawnThings(delta)
		
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	
func spawnThings(delta):
	timer += delta
	if (timer > spawnTime):
#		var path1Instance = path1.instantiate()
#		var path2Instance = path2.instantiate()
		var path3Instance = path3.instantiate()
#		add_child(path1Instance)
#		add_child(path2Instance)
		add_child(path3Instance)
		timer = 0
	

func increase_score(value):
	score += value
	
func decrease_lives():
	lives -= 1



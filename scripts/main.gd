extends Node2D

@onready var spawn_player_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer

@export var player_initial_position = Vector2(0,0)
@export var scroll_speed = 20.0

func pad_with_zeros(number, width):
	var str_num = str(number)
	while str_num.length() < width:
		str_num = "0" + str_num
	return str_num

var score = 0
var lives = 6

var timer = 0
var timer2 = 0
var mainTimer = 0
@export var spawnTime = .2
@export var spawnTime2 = .4
@export var spawnTime3 = .8

var speed = .05

var isMovingToPosition1 = false
var isMovingToPosition2 = false

var spawned_boss_1 = false
var spawned_boss_2 = false
var spawned_boss_final = false

var path1 = preload("res://paths/path1.tscn")
var boss = preload("res://paths/bosspath1.tscn")
var path2 = preload("res://paths/path2.tscn")
var path3 = preload("res://paths/path3.tscn")
var path10 = preload("res://paths/path10.tscn")
var path11 = preload("res://paths/path11.tscn")
var path50 = preload("res://paths/path50.tscn")
var path51 = preload("res://paths/path51.tscn")
var enemy_scene = preload("res://actors/enemy.tscn")

var path_follow51 = preload("res://paths/path51.tscn")
var path_follow52 = preload("res://paths/path52.tscn")
var path_follow53 = preload("res://paths/path53.tscn")
var path_follow54 = preload("res://paths/path54.tscn")
var path_follow55 = preload("res://paths/path55.tscn")
var path_follow56 = preload("res://paths/path56.tscn")
var path_follow57 = preload("res://paths/path57.tscn")
var cursorPosition1 = Vector2(20,70)
var cursorPosition2 = Vector2(300,70)

var player = null

func _ready():
#	add_child(boss.instantiate())

	
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = spawn_player_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)
	scene_manager.set_last_scene("res://scenes/main.tscn")

func _process(delta):
	mainTimer += delta
	
	var padded_score = pad_with_zeros(score, 8) 
	$score.text = "scr: " + padded_score
	var padded_lives = pad_with_zeros(lives, 2) 
	$lives.text = "<" + padded_lives
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	spawnThings(delta)
	
	if isMovingToPosition1:
		$Player.position = $Player.position.lerp(cursorPosition1, speed)
		
		if $Player.position.distance_to(cursorPosition1) < 1.0:
			isMovingToPosition1 = false
			isMovingToPosition2 = true
			
	if isMovingToPosition2:
		$Player.position = $Player.position.lerp(cursorPosition2, speed)
		
		if $Player.position.distance_to(cursorPosition2) < 1.0:
			get_tree().change_scene_to_file("res://scenes/transition.tscn")
		
		
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	
func spawnThings(delta):
	timer += delta
	timer2 += delta
	if (timer > spawnTime && mainTimer < 5):
		var path = path_follow51.instantiate()
		path.get_node("path").set_follower("res://actors/enemy3.tscn") 
		add_child(path)
		timer = 0
	if (timer > spawnTime && mainTimer > 7 && mainTimer < 14):
		var path3 = path_follow52.instantiate()
		path3.get_node("path").set_follower("res://actors/enemy3.tscn") 
		add_child(path3)
		timer = 0
	if (!spawned_boss_1 && mainTimer > 9):
		spawned_boss_1 = true
		var path = path_follow53.instantiate()
		path.get_node("path").set_follower("res://actors/boss.tscn") 
		path.get_node("path").set_delete_on_finish(false) 
		add_child(path)
	if (!spawned_boss_2 && mainTimer > 25):
		spawned_boss_2 = true
		var path = path_follow54.instantiate()
		path.get_node("path").set_follower("res://actors/boss.tscn") 
		path.get_node("path").set_delete_on_finish(false) 
		add_child(path)
	if (timer > spawnTime && mainTimer > 16 && mainTimer < 25):
		var path2 = path_follow55.instantiate()
		path2.get_node("path").set_follower("res://actors/enemy4.tscn") 
		add_child(path2)
		timer = 0
	if (timer > spawnTime && mainTimer > 28 && mainTimer < 32):
		var path56 = path_follow56.instantiate()
		path56.get_node("path").set_follower("res://actors/enemy5.tscn") 
		add_child(path56)
		timer = 0
	if (mainTimer > 40):
		win()
#	if (timer > spawnTime && mainTimer > 37 && mainTimer < 47):
#		var path57 = path_follow57.instantiate()
#		path57.get_node("path").set_follower("res://actors/enemy6.tscn") 
#		add_child(path57)
#		timer = 0
	

func win():
	if !isMovingToPosition1 && !isMovingToPosition2: 
		audio_manager.play_music2()
		isMovingToPosition1 = true
	
	
func increase_score(value):
	score += value
	
func decrease_lives():
	lives -= 1

func _on_player_killed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/continue.tscn")

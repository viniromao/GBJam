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

var boss_thing = 0

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
var final_boss = preload("res://actors/final_boss.tscn")

var path_follow51 = preload("res://paths/path51.tscn")
var path_follow52 = preload("res://paths/path52.tscn")
var path_follow53 = preload("res://paths/path53.tscn")
var path_follow54 = preload("res://paths/path54.tscn")
var path_follow55 = preload("res://paths/path55.tscn")
var path_follow56 = preload("res://paths/path56.tscn")
var path_follow57 = preload("res://paths/path57.tscn")
var path_follow58 = preload("res://paths/path58.tscn")
var path_follow59 = preload("res://paths/path59.tscn")
var path_follow60 = preload("res://paths/path60.tscn")
var path_follow61 = preload("res://paths/path61.tscn")
var path_follow62 = preload("res://paths/path62.tscn")
var path_follow63 = preload("res://paths/path63.tscn")
var path_follow64 = preload("res://paths/path64.tscn")
var path_follow65 = preload("res://paths/path65.tscn")
var path_follow66 = preload("res://paths/path66.tscn")
var path_follow67 = preload("res://paths/path67.tscn")
var path_follow68 = preload("res://paths/path68.tscn")
var path_follow69 = preload("res://paths/path69.tscn")
var path_follow70 = preload("res://paths/path70.tscn")
var path_follow71 = preload("res://paths/path71.tscn")
var sky_shot = preload("res://actors/fall_shot.tscn")
var cursorPosition1 = Vector2(20,70)
var cursorPosition2 = Vector2(300,70)

var boss_deployed = false

var player = null

func _ready():
#	add_child(boss.instantiate())
	spawnTime = .2
	audio_manager.stop_music()
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = spawn_player_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)
	scene_manager.set_last_scene("res://scenes/level3.tscn")

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
	if (timer > spawnTime && mainTimer < 15):
		var path57 = path_follow57.instantiate()
		path57.get_node("path").set_follower("res://actors/enemy7.tscn") 
		add_child(path57)
		timer = 0
	if (timer2 > spawnTime && mainTimer > 15  && mainTimer < 25):
		var path58 = path_follow58.instantiate()
		path58.get_node("path").set_follower("res://actors/enemy8.tscn") 
		add_child(path58)
		timer2 = 0
	if (timer > spawnTime * 5 && mainTimer > 25  && mainTimer < 30):
		var path59 = path_follow59.instantiate()
		path59.get_node("path").set_follower("res://actors/boss.tscn") 
		add_child(path59)
		timer = 0
	if (timer > spawnTime * 5 && mainTimer > 30  && mainTimer < 35):
		var path60 = path_follow60.instantiate()
		path60.get_node("path").set_follower("res://actors/boss.tscn") 
		add_child(path60)
		timer = 0
	if (timer > spawnTime  && mainTimer > 35  && mainTimer < 45):
		var path61 = path_follow61.instantiate()
		path61.get_node("path").set_follower("res://actors/enemy3.tscn") 
		add_child(path61)
		timer = 0
	if (timer2 > spawnTime  && mainTimer > 40  && mainTimer < 55):
		var path62 = path_follow62.instantiate()
		path62.get_node("path").set_follower("res://actors/enemy3.tscn") 
		add_child(path62)
		timer2 = 0
	if (timer2 > spawnTime  && mainTimer > 55  && mainTimer < 70):
		var path64 = path_follow64.instantiate()
		path64.get_node("path").set_follower("res://actors/enemy4.tscn") 
		add_child(path64)
		timer2 = 0
	if (timer > spawnTime  && mainTimer > 55  && mainTimer < 65):
		var path65 = path_follow65.instantiate()
		path65.get_node("path").set_follower("res://actors/enemy8.tscn") 
		add_child(path65)
		timer = 0
	if (timer > spawnTime  && mainTimer > 65  && mainTimer < 75):
		var path66 = path_follow66.instantiate()
		path66.get_node("path").set_follower("res://actors/enemy7.tscn") 
		add_child(path66)
		timer = 0
	if (timer > spawnTime  && mainTimer > 75  && mainTimer < 85):
		var path67 = path_follow67.instantiate()
		path67.get_node("path").set_follower("res://actors/enemy4.tscn") 
		add_child(path67)
		timer = 0
	if (timer > spawnTime  && mainTimer > 85  && mainTimer < 95):
		var path68 = path_follow68.instantiate()
		path68.get_node("path").set_follower("res://actors/enemy3.tscn") 
		add_child(path68)
		timer = 0
	if (timer > spawnTime  && mainTimer > 95  && mainTimer < 105):
		var path69 = path_follow69.instantiate()
		path69.get_node("path").set_follower("res://actors/enemy8.tscn") 
		add_child(path69)
		timer = 0
	if (timer > spawnTime  && mainTimer > 105  && mainTimer < 115):
		var path70 = path_follow70.instantiate()
		path70.get_node("path").set_follower("res://actors/enemy7.tscn") 
		add_child(path70)
		timer = 0
	if (mainTimer > 115):
		if !boss_deployed:
			$skyshot_timer.start()
			boss_deployed = true
			var path71 = path_follow71.instantiate()
			path71.get_node("path").set_follower("res://actors/final_boss.tscn")
			path71.get_node("path").set_delete_on_finish(false)  
			add_child(path71)
			boss_thing = path71.get_node("path/Boss")
		if (boss_thing.isDead):
			get_tree().change_scene_to_file("res://scenes/final_cut_scene.tscn")
	
func win():
	if !isMovingToPosition1 && !isMovingToPosition2: 
		audio_manager.play_music2()
		isMovingToPosition1 = true
	
	
func increase_score(value):
	score += value
	
func decrease_lives():
	lives -= 1

func _on_player_killed():
		get_tree().change_scene_to_file("res://scenes/continue.tscn")


func _on_skyshot_timer_timeout():
	add_child(sky_shot.instantiate())

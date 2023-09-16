extends Node2D


var cursorPosition1 = Vector2(20,99)
var cursorPosition2 = Vector2(83,88)
var cursorPosition3 = Vector2(18,26)
var cursorPosition4 = Vector2(19,72)
var speed = .05
var speed2 = .01
var isMovingToPosition2 = false
var isMovingToPosition3 = false
var isMovingToPosition4 = false
var text_lines = ["Changes not staged for commit:\n", "  (use git add <file>... to \n", "update what will be committed)\n", "  (use git restore <file>...to \n", "discard changes in working \n", "directory)\n", "    modified:   scripts/main.gd\n", "    modified:   scripts/player.gd\n", "Untracked files:\n", "  (use git add <file>... to\n", "include in what will be committed)\n", "     assets/alert.png\n", "     assets/alert.png.import\n", "     assets/button.png\n", "     assets/button.png.import\n", "     assets/cursor.png\n", "     assets/popup.png\n", "     assets/popup.png.import\n", "     assets/terminal.png\n", "     scenes/firstCutScene.tscn\n", "     scripts/firstCutScene.gd\n", "\n", "no changes added to commit (use\n", "git add and/or git commit -a)\n", "PS C:-Users-someUser-OneDrive-\n", "Desktop-GBJam>\n"]
var text_lines2 = ["THE\n\n", "DISK\n\n", "IS\n\n", "FULL\n\n", "OF\n\n", "VIRUSES\n\n"]
var current_line = 0
var current_line2 = 0
var animation_ended = false

var terminalIsVisible = false

func _ready():
	$popup.visible = false  
	$cursor.position = Vector2(100, 50) 
	$textTimer.set_wait_time(0.05)
	$errorTimer.set_wait_time(.5)
	var timer = get_node("textTimer")
	var errorTimer = get_node("errorTimer")
	timer.timeout.connect(_on_textTimer_timeout)
	errorTimer.timeout.connect(_on_errorTimer_timeout)
	
	

func _process(delta):
	
	if isMovingToPosition4:
		var direction = (cursorPosition4 - $icon.position).normalized()
		$icon.position += direction * speed * 10
		
		if $icon.position.distance_to(cursorPosition4) < 1.0:
			start_antivirus_animation()
			isMovingToPosition4 = false
		
	if(isMovingToPosition3):
		$cursor.position = $cursor.position.lerp(cursorPosition3, speed)
		
		if $cursor.position.distance_to(cursorPosition3) < 1.0:
			var timer = get_tree().create_timer(.5)
			await timer.timeout
			isMovingToPosition3 = false
			start_antivirus()
			
	
	if animation_ended:
		$terminal.visible = false		
		return
	
	if !isMovingToPosition2:
		$cursor.position = $cursor.position.lerp(cursorPosition1, speed)
		
		if $cursor.position.distance_to(cursorPosition1) < 1.0:
			var timer = get_tree().create_timer(.5)
			await timer.timeout
			
			$popup.visible = true
			
			var timer2 = get_tree().create_timer(1.0)
			await timer2.timeout
			
			isMovingToPosition2 = true
	else:
		$cursor.position = $cursor.position.lerp(cursorPosition2, speed)

		if $cursor.position.distance_to(cursorPosition2) < 1.0:
			var timer = get_tree().create_timer(3)
			await timer.timeout
			if !terminalIsVisible && !animation_ended:
				$textTimer.start()
				terminalIsVisible = true
				$popup.visible = false  
				$terminal.visible = true
				$cursor.visible = false
				
func _on_textTimer_timeout():
	if current_line < text_lines.size():
		get_node("terminal/terminalText").text += text_lines[current_line]
		current_line += 1
	else:
		$textTimer.stop()
		get_node("terminal/terminalText").text = ""
		$errorTimer.start()
		
		
func _on_errorTimer_timeout():
	if animation_ended: 
		$terminal.visible = false
		return
	
	if current_line2 < text_lines2.size():
		get_node("terminal/errorText").text += text_lines2[current_line2]
		current_line2 += 1
	else:
		var timer = get_tree().create_timer(1)
		await timer.timeout
		$errorTimer.stop() 
		get_node("terminal/errorText").text = ""
		$Skull.visible = true
		get_node("Skull/AnimationPlayer").play("skull")
	
		start_final_animation()
		
func _on_flickerTimer_timeout():
	$trash_icon.visible = not $trash_icon.visible
	$internet_icon.visible = not $internet_icon.visible
	$Label.visible = not $Label.visible
	
func _on_flickerTimer_timeout2():
	$icon.visible = not $icon.visible
		
func start_final_animation(): 
	var timer2 = get_tree().create_timer(3)
	await timer2.timeout
	terminalIsVisible = false
	$terminal.visible = false
	$Skull.visible = false
	$textTimer.stop()
	$errorTimer.stop()
	animation_ended = true
	$cursor.visible = true
	isMovingToPosition3 = true
	
func start_antivirus():
	$flickerTimer.start()
	$flickerTimer.set_wait_time(.05)
	var flickerTimer = get_node("flickerTimer")	
	flickerTimer.timeout.connect(_on_flickerTimer_timeout)
	var timer2 = get_tree().create_timer(3)
	await timer2.timeout
	$trash_icon.visible = false
	$internet_icon.visible = false
	$Label.visible = false
	$flickerTimer.stop()
	isMovingToPosition4 = true
	
func start_antivirus_animation():
	$flickerTimer2.start()
	$flickerTimer2.set_wait_time(.05)
	var flickerTimer2 = get_node("flickerTimer2")	
	flickerTimer2.timeout.connect(_on_flickerTimer_timeout2)
	var timer2 = get_tree().create_timer(3)
	await timer2.timeout
	$flickerTimer2.stop()	
	$icon.visible = true
	$icon.rotation_degrees -= 90
	var timer = get_tree().create_timer(3)
	await timer.timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	

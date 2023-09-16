extends Node2D


var cursorPosition1 = Vector2(20,99)
var cursorPosition2 = Vector2(83,88)
var speed = .05
var isMovingToPosition2 = false
var text_lines = ["Changes not staged for commit:\n", "  (use git add <file>... to \n", "update what will be committed)\n", "  (use git restore <file>...to \n", "discard changes in working \n", "directory)\n", "    modified:   scripts/main.gd\n", "    modified:   scripts/player.gd\n", "Untracked files:\n", "  (use git add <file>... to\n", "include in what will be committed)\n", "     assets/alert.png\n", "     assets/alert.png.import\n", "     assets/button.png\n", "     assets/button.png.import\n", "     assets/cursor.png\n", "     assets/popup.png\n", "     assets/popup.png.import\n", "     assets/terminal.png\n", "     scenes/firstCutScene.tscn\n", "     scripts/firstCutScene.gd\n", "\n", "no changes added to commit (use\n", "git add and/or git commit -a)\n", "PS C:-Users-someUser-OneDrive-\n", "Desktop-GBJam>\n"]
var current_line = 0

var terminalIsVisible = false

func _ready():
	$popup.visible = false  
	$cursor.position = Vector2(100, 50) 
	$textTimer.set_wait_time(0.05)
	var timer = get_node("textTimer")
	timer.timeout.connect(_on_textTimer_timeout)
	
	

func _process(delta):
	if !isMovingToPosition2:
		$cursor.position = $cursor.position.lerp(cursorPosition1, speed)
		
		if $cursor.position.distance_to(cursorPosition1) < 1.0:
			var timer = get_tree().create_timer(0.5)
			await timer.timeout
			
			$popup.visible = true
			
			var timer2 = get_tree().create_timer(1.0)
			await timer2.timeout
			
			isMovingToPosition2 = true
	else:
		$cursor.position = $cursor.position.lerp(cursorPosition2, speed)

		if $cursor.position.distance_to(cursorPosition2) < 1.0:
			var timer = get_tree().create_timer(0.5)
			await timer.timeout
			if !terminalIsVisible:
				$textTimer.start()
				terminalIsVisible = true
				$terminal.visible = true
				$textTimer.start()
				
func _on_textTimer_timeout():
	if current_line < text_lines.size():
		get_node("terminal/terminalText").text += text_lines[current_line]
		current_line += 1
	else:
		$textTimer.stop()  # Stop the timer if there are no more lines

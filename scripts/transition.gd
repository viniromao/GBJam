extends Control

var dots = ""
var loading_text = "Scanning files"
var pitch: float = 0.11  # Initial pitch
var pitch_increment: float = 0.01  # Amount to change the pitch each frame
var max_pitch: float = 1.0  # Maximum pitch
var min_pitch: float = 0.1  # Minimum pitch
var show_text = false
var slow_down_noise = false
var slow_down_velocity = 0.1
var text_lines = ["Changes not staged for commit:\n", "  (use git add <file>... to \n", "update what will be committed)\n", "  (use git restore <file>...to \n", "discard changes in working \n", "directory)\n", "    modified:   scripts/main.gd\n", "    modified:   scripts/player.gd\n", "Untracked files:\n", "  (use git add <file>... to\n", "include in what will be committed)\n", "     assets/alert.png\n", "     assets/alert.png.import\n", "     assets/button.png\n", "     assets/button.png.import\n", "     assets/cursor.png\n", "     assets/popup.png\n", "     assets/popup.png.import\n", "     assets/terminal.png\n", "     scenes/firstCutScene.tscn\n", "     scripts/firstCutScene.gd\n", "\n", "no changes added to commit (use\n", "git add and/or git commit -a)\n", "PS C:-Users-someUser-OneDrive-\n", "Desktop-GBJam>\n"]
var text_lines2 = ["Loading Files...\n", "Loading GBJAM competitors\n", "Loading all the stuff we need\n", "Loading CAT PHOTOS\n", "Are you reading this?\n", "Loading a lot of random stuff\n", "Loading easter eggs\n", "Loading very cute cat photos" ]
var current_line = 0
var current_line2 = 0
var update_text = true

func _ready():
	$Timer.start()  # Start the main Timer when the scene loads.
	$dots_timer.start()  # Start the DotsTimer to control dot appearance.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if show_text && update_text:
		$text.text = loading_text + dots
		
	if pitch_increment == 0: return
	
	pitch += pitch_increment  # Increment the pitch

	if pitch >= max_pitch:
		pitch_increment *= 0
		$click.play()
		show_text = true
		
		var timer = get_tree().create_timer(2)
		await timer.timeout
		
		slow_down_noise = true
		
		var timer2 = get_tree().create_timer(2)
		await timer2.timeout
		
		$text.text = ""
		update_text = false
		$text_timer.start()
		
		
		

# This function will be triggered when DotsTimer times out.
func _on_dots_timer_timeout():
	# Append one dot at a time until we have 3 dots.
	if dots.length() < 3:
		dots += "."
	else:
		# Reset the dots string if we have 3 dots.
		dots = ""

	
func _on_text_timer_timeout():
	if current_line < text_lines.size():
		if not $terminal_sound.playing:
			$terminal_sound.play()
		$text.text += text_lines[current_line]
		current_line += 1
	else:
		$text_timer.stop()
		$terminal_sound.stop()
		$text.text = ""
		$text2.visible = true
		$click.play()
		
		
		var timer = get_tree().create_timer(3)
		await timer.timeout
		$click.play()
		$text2.text = "Getting deeper into the system to 
		clean the disk"  + dots
		
		var timer2 = get_tree().create_timer(5)
		await timer2.timeout
		
		get_tree().change_scene_to_file("res://scenes/bonus_scene.tscn")
		audio_manager.stop_music()
		

extends AudioStreamPlayer

var pitch: float = 1.0  # Initial pitch
var pitch_increment: float = 0.01  # Amount to change the pitch each frame
var max_pitch: float = 2.0  # Maximum pitch
var min_pitch: float = 1.0  # Minimum pitch

func _ready():
	play()
	pitch_scale = pitch  # Set initial pitch

func _process(delta):
	if pitch_increment == 0: return
	
	
	pitch += pitch_increment  # Increment the pitch

	# Check for pitch boundaries and reverse the increment direction
	if pitch >= max_pitch or pitch <= min_pitch:
		pitch_increment *= 0
		get_parent().get_node("click").play()

	pitch_scale = pitch  # Apply the new pitch

	# Loop the audio with the last pitch when it finishes
	if playing == false:
		play


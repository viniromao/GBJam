extends Node

var audio_stream_player = AudioStreamPlayer.new()
var music_stream = preload("res://assets/sfx&songs/The_Virus_Appears.wav")
var music_stream2 = preload("res://assets/sfx&songs/victory.wav")

func _ready():
	add_child(audio_stream_player)

func play_music():
	audio_stream_player.stream = music_stream
	if not audio_stream_player.playing:
		audio_stream_player.play()
		
func play_music2():
	audio_stream_player.stream = music_stream2
	if not audio_stream_player.playing:
		audio_stream_player.play()

func stop_music():
	audio_stream_player.stop()
	

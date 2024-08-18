extends Node
var bgmusic1 = load("res://assets/music/bg_music_retro.wav")

func play_music1():
	$Music.stream = bgmusic1
	$Music.play()

func stop():
	$Music.stop()

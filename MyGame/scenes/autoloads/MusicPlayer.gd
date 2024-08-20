extends Node
var bgmusic_mainMenu = load("res://assets/music/bg_music_retro.wav")
var bgmusic_calm = load("res://assets/music/bg_music_calm.wav")
var fight_music = load("res://assets/music/intense_music.wav")
var final_fight = load("res://assets/music/intense_music_2.wav")
var teleport = load("res://assets/music/SoundEffects/teleport_sound.mp3")
@onready var player = $Music

func play_music1():
	player.stream = bgmusic_mainMenu
	player.play()
func stop():
	player.stop()
func play_music_calm():
	player.stream = bgmusic_calm
	player.play()
func play_music_fight():
	player.stream = fight_music
	player.play()
func teleport_sound():
	player.stream = teleport
	player.play()

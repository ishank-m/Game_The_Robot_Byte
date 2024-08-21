extends Node2D
var speed = 45
@onready var path = $Path2D/PathFollow2D
@onready var path_mc = $Path2D2/PathFollow2D
@onready var player = get_node("Player")
var anim_playing = false
var anim_playing_mc = false
var cutscene = true
var once = false
@onready var transition = $TransitionScene
var transition_playing = true
# Called when the node enters the scene tree for the first time.
func _ready():
		$Player.walk = load("res://assets/music/SoundEffects/walk_on_stone.mp3")
		GameState.pausable = false
		GameState.scene = "throne_room"
		$walk2.play()
		$walk.play()
		transition.fade_out()
		transition.connect("fade_out_done", _on_fade_out_done)
		transition.connect("fade_in_done", _on_fade_in_done)
		$transitions/clouds.visible = false
		$Path2D2/PathFollow2D/mc.visible = true
		$Player.set_position($Path2D2/PathFollow2D.position)
		$Player.visible = false
		GameState.game_state = "pause"
		Dialogic.signal_event.connect(_on_dialogic_signal)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not transition_playing:
		if cutscene:
			$Player.set_position($Path2D2/PathFollow2D.position)
		path.progress += speed*delta
		path_mc.progress += speed*delta
		if path.progress_ratio < 0.9 and not anim_playing:
			$Path2D/PathFollow2D/King.play("up") 
			anim_playing = true
		elif path.progress_ratio < 1 and path.progress_ratio>=0.9:
			anim_playing = false
			if not anim_playing:
				$Path2D/PathFollow2D/King.play("right")
				anim_playing = true
		elif path.progress_ratio == 1.0 and anim_playing:
			anim_playing = false
			$Path2D/PathFollow2D/King.play("down")
			$Path2D/PathFollow2D/King.stop()
			GameState.pausable = false
			$Player.stop()
			Dialogic.start("inpalace1")
			$walk.stop()
		if path_mc.progress_ratio < 1 and not anim_playing_mc:
			$Path2D2/PathFollow2D/mc.play("up")
			anim_playing_mc = true
		if path_mc.progress_ratio == 1:
			$Path2D2/PathFollow2D/mc.stop()
			$walk2.stop()

func _on_dialogic_signal(argument):
	if argument == "done1":
		$Path2D2/PathFollow2D/mc.visible = false
		$Player.visible = true
		GameState.game_state = "play"
		cutscene = false
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		GameState.pausable = true
	elif argument == "done2":
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		GameState.game_state = "play"
		GameState.pausable = true
	elif argument == "done3":
		GameState.game_state = "play"
		GameState.pausable = true

func _on_fade_out_done():
	transition_playing = false
	
func _on_fade_in_done():
	pass
func _on_area_2d_body_entered(body):
	if body.name == "Player" and not once:
		once = true
	elif body.name == "Player" and once:
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		GameState.pausable = false
		$Player.stop()
		Dialogic.start("inpalace2")


func _on_end_dialogue_trigger_body_entered(body):
	if body.name == "Player":
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		GameState.pausable = false
		$Player.stop()
		Dialogic.start("inpalace3")


func _on_scene_change_trigger_body_entered(body):
	if body.name == "Player":
		MusicPlayer.teleport_sound()
		GameState.game_state = "pause"
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		$transitions/clouds.visible = true
		$transitions/clouds.play("bye")


func _on_clouds_animation_finished():
	get_tree().change_scene_to_file("res://scenes/Ending/EndingScene.tscn")

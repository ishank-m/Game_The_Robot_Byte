extends Node2D
@onready var transition = $TransitionScene

func _ready():
	$Player.walk = load("res://assets/music/SoundEffects/walk_wood.wav")
	GameState.scene = "end"
	$transitions/clouds.visible = true
	$transitions/clouds.play("hi")
	$TransitionScene.visible = false
	$Player.visible = false
	$"player incoming".visible = false
	transition.connect("fade_in_done", _on_fade_in_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/Ending/EndCredits.tscn")

func _on_dialogic_signal(argument):
	if argument == "done1":
		GameState.game_state = "play"
		$Timer.start()
	elif argument == "done2":
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		GameState.game_state = "play"
	elif argument == "call":
		$call.play()
	elif argument == "done3":
		GameState.game_state = "play"


func _on_player_incoming_animation_finished():
	$Player.visible = true
	$"player incoming".visible = false
	MusicPlayer.stop()
	Dialogic.start("endscene1")


func _on_stairs_1_body_entered(body):
	if body.name == "Player":
		transition.fade_in()


func _on_stairs_2_body_entered(body):
	if body.name == "Player":
		transition.fade_in()


func _on_out_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		Dialogic.start("endscene2")


func _on_timer_timeout():
	GameState.game_state = "pause"
	$Player/Player_sprite.stop()
	Dialogic.start("endscene3")


func _on_clouds_animation_finished():
	$transitions/clouds.visible = false
	$"player incoming".visible = true
	$"player incoming".play("appear")

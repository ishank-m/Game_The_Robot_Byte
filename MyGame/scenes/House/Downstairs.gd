extends Node2D
var count = 0
@onready var player = get_node("Player")
@onready var transition = $TransitionScene

func _ready():
	transition.fade_out()
	transition.connect("fade_out_done", _on_fade_out_done)
	transition.connect("fade_in_done", _on_fade_in_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if GameState.scene == "init":
		player.set_position($init.position)
	elif GameState.scene == "lobby":
		GameState.game_state = "play"
		player.set_position($Lobby.position)
	if GameState.player_pos:
		player.position = GameState.player_pos
		GameState.player_pos = null
	GameState.scene = "downstairs"

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")
func _on_fade_out_done():
	pass

func _on_stairs_body_entered(body):
	if body.name == "Player":
		GameState.stairs = true

func _on_stairs_body_exited(body):
	if body.name == "Player":
		GameState.stairs = false

func _on_upstairs_body_entered(body):
	if body.name == "Player":
		transition.fade_in()

func _on_dialogic_signal(argument: String):
	if argument == "end" or argument == "done":
		GameState.game_state = "play"
	elif argument == "done3":
		$Player/Player.play("up")
		$Player/Player.stop()
		GameState.game_state = "play"

func _on_dialogue_body_entered(body):
	if body.name == "Player" and count == 0:
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("downstairs_2")
		count = 1
	elif body.name == "Player" and count == 1:
		count = 0

func _on_out_body_entered(body):
	if body.name == "Player" and GameState.dialogues_count['downstairs'] == 0:
		GameState.game_state = "pause"
		Dialogic.start("downstairs")
		GameState.dialogues_count['downstairs'] = 1
	elif body.name == "Player" and GameState.dialogues_count['downstairs'] == 1:
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("downstairs3")

extends Node2D
var entered = false
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if GameState.scene == "init":
		$Player.set_position($init.position)
		GameState.scene = "downstairs"
		Dialogic.start("downstairs")
	elif GameState.scene == "lobby":
		GameState.game_state = "play"
		$Player.set_position($Lobby.position)
		GameState.scene = "downstairs"

func _process(_delta):
	if entered:
		get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")
	if Input.is_action_pressed("ui_cancel"):
		GameState.game_state = 'pause'
	if Input.is_action_pressed("save"):
		GameState.save()

func _on_button_pressed():
	GameState.game_state = "main_menu"
	get_tree().change_scene_to_file('res://scenes/Mainmenu/mainmenu.tscn')


func _on_out_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "play"
		get_tree().change_scene_to_file("res://scenes/Mainmenu/mainmenu.tscn")


func _on_stairs_body_entered(body):
	if body.name == "Player":
		GameState.stairs = true
		


func _on_stairs_body_exited(body):
	if body.name == "Player":
		GameState.stairs = false

	


func _on_upstairs_body_entered(body):
	if body.name == "Player":
		entered = true

func _on_dialogic_signal(argument: String):
	if argument == "end":
		GameState.game_state = "play"
	if argument == "done":
		GameState.game_state = "play"


func _on_dialogue_body_entered(body):
	if body.name == "Player":
		$Player/Player.stop()
		GameState.game_state = "pause"
		Dialogic.start("downstairs_2")

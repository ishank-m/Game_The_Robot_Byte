extends Node2D
var entered = false
func _ready():
	GameState.game_state= 'play'
	if GameState.scene == "init":
		$Player.set_position($init.position)
		GameState.scene = "downstairs"
	elif GameState.scene == "lobby":
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

	

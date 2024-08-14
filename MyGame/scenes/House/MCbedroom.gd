extends Node2D
@onready var transition = $TransitionScene
@onready var player = get_node("Player")
func _ready():
	transition.fade_out()
	transition.connect("fade_out_done", _on_fade_out_done)
	transition.connect("fade_in_done", _on_fade_in_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if GameState.scene == "lobby":
		$Player/Player.play("down")
		$Player/Player.stop()
		player.set_position($door_pos.position)
	GameState.scene  = "mc_bedroom"
func _on_fade_out_done():
	GameState.game_state = "play"
func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")
func _on_timer_timeout():
	if GameState.dialogues_count['mcbed'] == 0:
		GameState.game_state = "pause"
		$Player/Player.stop()
		Dialogic.start("mcbedroom")
		GameState.dialogues_count['mcbed'] = 1

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		GameState.game_state = 'pause'
		$Player/Player.play("up")
		$Player/Player.stop()
		$door.play("open")


func _on_door_animation_finished():
	transition.fade_in()
	

		
func _on_dialogic_signal(argument):
	if argument == "done":
		GameState.game_state = 'play'
	if argument == "done2":
		GameState.game_state = 'play'

func _on_for_dialogue_timeout():
	$Player/Player.stop()
	GameState.game_state = 'pause'
	Dialogic.start("mcbedroom_2")

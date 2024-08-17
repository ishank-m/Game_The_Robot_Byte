extends Node2D
@onready var player = get_node("Player")
@onready var transition = $TransitionScene
var to_where: String

func _ready():
	GameState.game_state = "play"
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if GameState.scene == "downstairs":
		$Player.set_position($down.position)
	elif GameState.scene == 'mc_bedroom':
		$Player.set_position($mc_bedroom.position)
	elif GameState.scene == "room_2":
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		$Player.set_position($room_2.position)
	if GameState.player_pos:
		player.position = GameState.player_pos
		GameState.player_pos = null
	GameState.scene = "lobby"


func _on_fade_in_done():
	if to_where == "winroom":
		get_tree().change_scene_to_file("res://scenes/House/wardroom.tscn")
	elif to_where == "downstairs":
		get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")
	elif to_where == "mcbedroom":
		get_tree().change_scene_to_file("res://scenes/House/MCbedroom.tscn")

func _on_downstairs_body_entered(body: Node2D):
	if body.name == "Player":
		to_where = "downstairs"
		transition.fade_in()

func _on_wdoor_body_entered(body: Node2D):
	if body.name == "Player":
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		$door.play("open")

func _on_door_animation_finished():
	to_where = "winroom"
	transition.fade_in()

func _on_bedroom_body_entered(body: Node2D):
	if body.name == "Player":
		GameState.game_state = "pause"
		to_where = "mcbedroom"
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		transition.fade_in()
		

func _on_stairs_body_entered(body):
	if body.name == "Player":
		GameState.stairs = true
		

func _on_stairs_body_exited(body):
	if body.name == "Player":
		GameState.stairs = false


func _on_dialogue_parents_body_entered(body):
	if body.name == "Player" and GameState.dialogues_count["lobby1"] == 0:
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_1")
		GameState.dialogues_count["lobby1"] = 1
		
func _on_dialogic_signal(argument: String):
	if argument == "done":
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		GameState.game_state = "play"
	if argument == "done2":
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		GameState.game_state = "play"
	if argument == "done3":
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		GameState.game_state = "play"


func _on_dialogue_mc_body_entered(body):
	if body.name == "Player" and GameState.dialogues_count['lobby2'] == 0:
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_2")
		GameState.dialogues_count['lobby2'] = 1

func _on_dialogue_sis_body_entered(body):
	if body.name == "Player" and GameState.dialogues_count['lobby3'] == 0:
		$Player/Player_sprite.play("down")
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_3")
		GameState.dialogues_count['lobby3'] = 1

func _on_dialogue_win_body_entered(body):
	if body.name == "Player" and GameState.dialogues_count['lobby4'] == 0:
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_4")
		GameState.dialogues_count['lobby4'] = 1

extends Node2D
var entered = false
var enter3 = false
var to = ''

func _ready():
	$CanvasLayer/ColorRect.visible = true
	$transition.play("hi")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if GameState.scene == "downstairs":
		$Player.set_position($down.position)
		GameState.scene = "lobby"
	elif GameState.scene == 'mc_bedroom':
		$Player.set_position($mc_bedroom.position)
		GameState.scene = "lobby"
	elif GameState.scene == "room_2":
		$Player.set_position($room_2.position)
		GameState.scene = "lobby"

func _process(_delta):
	if entered:
		get_tree().change_scene_to_file("res://scenes/House/Downstairs.tscn")
	if enter3:
		get_tree().change_scene_to_file("res://scenes/House/MCbedroom.tscn")

func _on_downstairs_body_entered(body: Node2D):
	if body.name == "Player":
		GameState.game_state = "wait"
		entered = true

func _on_wdoor_body_entered(body: Node2D):
	if body.name == "Player":
		GameState.game_state = "wait"
		$door.play("open")

func _on_door_animation_finished():
	get_tree().change_scene_to_file("res://scenes/House/wardroom.tscn")

func _on_bedroom_body_entered(body: Node2D):
	if body.name == "Player":
		to = "MCBedroom"
		$CanvasLayer/ColorRect.visible = true
		$transition.play("bye")
		

func _on_stairs_body_entered(body):
	if body.name == "Player":
		GameState.stairs = true
		

func _on_stairs_body_exited(body):
	if body.name == "Player":
		GameState.stairs = false


func _on_dialogue_parents_body_entered(body):
	if body.name == "Player":
		$Player/Player.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_1")

func _on_dialogic_signal(argument: String):
	if argument == "done":
		$Player/Player.play("down")
		$Player/Player.stop()
		GameState.game_state = "play"
	if argument == "done2":
		$Player/Player.play("up")
		$Player/Player.stop()
		GameState.game_state = "play"
	if argument == "done3":
		$Player/Player.play("up")
		$Player/Player.stop()
		GameState.game_state = "play"


func _on_dialogue_mc_body_entered(body):
	if body.name == "Player":
		$Player/Player.play("down")
		$Player/Player.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_2")


func _on_dialogue_sis_body_entered(body):
	if body.name == "Player":
		$Player/Player.play("down")
		$Player/Player.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_3")


func _on_dialogue_win_body_entered(body):
	if body.name == "Player":
		$Player/Player.stop()
		GameState.game_state = "pause"
		Dialogic.start("lobby_4")


func _on_transition_animation_finished(anim_name):
	if anim_name == "hi":
		GameState.game_state = 'play'
		$CanvasLayer/ColorRect.visible = false
	if anim_name == "bye":
		if to == "MCBedroom":
			get_tree().change_scene_to_file("res://scenes/House/MCbedroom.tscn")

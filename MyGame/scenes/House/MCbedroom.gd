extends Node2D

func _ready():
	GameState.game_state = 'pause'
	$CanvasLayer/ColorRect.visible = true
	$transition.play("hi")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if GameState.scene == "lobby":
		$Player/Player.play("down")
		$Player/Player.stop()
		$Player.set_position($door_pos.position)
		GameState.scene  = "mc_bedroom"

func _on_timer_timeout():
	Dialogic.start("mcbedroom")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$door.play("open")


func _on_door_animation_finished():
	GameState.scene = "mc_bedroom"
	$CanvasLayer/ColorRect.visible = true
	$transition.play("bye")
	


func _on_transition_animation_finished(anim_name):
	if anim_name == "hi":
		$CanvasLayer/ColorRect.visible = false
	elif anim_name == 'bye':
		get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")
		
func _on_dialogic_signal(argument):
	if argument == "done":
		GameState.game_state = 'play'
	if argument == "done2":
		GameState.game_state = 'play'

func _on_for_dialogue_timeout():
	$Player/Player.stop()
	GameState.game_state = 'pause'
	Dialogic.start("mcbedroom_2")

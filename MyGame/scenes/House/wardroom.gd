extends Node2D
var playing = false

func _ready():
	$CanvasLayer/ColorRect.visible = true
	$transition.play("hi")
	$transitions/light.visible = true
	$transitions/light.color = "000000d3"
	$char_opening_win.hide()
	$char_going.hide()
	$TileMap.frame = 0
	Dialogic.start("winroom")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	GameState.game_state = 'pause'
	if GameState.scene == "lobby":
		$Player.set_position($room_2.position)
		GameState.scene  = "room_2"


func _on_timer_timeout():
	if not playing:
		$char_going.show()
		$char_opening_win.hide()
		$char_going.play("bye")
		playing = true

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$light.play("lightening")
		$char_opening_win.show()
		$Player.hide()
		$char_opening_win.play("open")
		$char_opening_win/Timer.start()
		$TileMap.play("default")


func _on_char_going_animation_finished():
	$transitions/layer.start()


func _on_layer_timeout():
	$transitions/clouds.visible = true
	$transitions/clouds.play("bye")



func _on_door_body_entered(body):
	if body.name == "Player":
		$door/change.start()


func _on_change_timeout():
	get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")


func _on_light_animation_finished(anim_name):
	if anim_name == "lightening":
		$transitions/light.visible = false


func _on_transition_animation_finished(anim_name):
	if anim_name == "hi":
		$CanvasLayer/ColorRect.visible = false
		GameState.game_state = 'play'


func _on_clouds_animation_finished():
	GameState.scene = "window"
	get_tree().change_scene_to_file("res://scenes/world/world_init.tscn")

func _on_dialogic_signal(_argument):
	pass

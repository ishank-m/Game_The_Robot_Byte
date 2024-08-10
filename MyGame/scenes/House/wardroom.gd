extends Node2D
var playing = false

func _ready():
	$char_opening_win.hide()
	$char_going.hide()
	$TileMap.frame = 0
	GameState.game_state = 'play'
	if GameState.scene == "lobby":
		$Player.set_position($room_2.position)
		GameState.scene  = "room_2"





func _on_hi_animation_finished():
	GameState.scene = "window"
	get_tree().change_scene_to_file("res://scenes/world/world_init.tscn")


func _on_timer_timeout():
	if not playing:
		$char_going.show()
		$char_opening_win.hide()
		$char_going.play("bye")
		playing = true

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$char_opening_win.show()
		$Player.hide()
		$char_opening_win.play("open")
		$char_opening_win/Timer.start()
		$TileMap.play("default")


func _on_char_going_animation_finished():
	$CanvasLayer/layer.start()


func _on_layer_timeout():
	$CanvasLayer/hi.play("bye")



func _on_door_body_entered(body):
	if body.name == "Player":
		$door/change.start()


func _on_change_timeout():
	get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")

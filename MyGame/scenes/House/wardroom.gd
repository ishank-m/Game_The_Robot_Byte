extends Node2D
var playing = false
@onready var transition = $TransitionScene
@onready var player = get_node("Player")

func _ready():
	MusicPlayer.stop()
	transition.fade_out()
	transition.connect("fade_out_done", _on_fade_out_done)
	$physics.hide()
	GameState.game_state = "pause"
	$transitions/light.visible = true
	$transitions/light.color = "000000d3"
	$char_opening_win.hide()
	$char_going.hide()
	$TileMap.animation = "part1"
	$TileMap.frame = 0
	Dialogic.start("winroom")
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if GameState.scene == "lobby":
		$Player.set_position($room_2.position)
		GameState.scene  = "window"
func _on_fade_out_done():
	GameState.game_state = "pause"


func _on_area_2d_body_entered(body):
	if body.name == "Player" and not playing:
		GameState.game_state = "pause"
		$light.play("lightening")
		$char_opening_win.show()
		$Player.hide()
		$char_opening_win.play("open")
		$TileMap.play("part1")
		playing = true

func _on_char_going_animation_finished():
	$transitions/clouds.visible = true
	$transitions/clouds.play("bye")


func _on_door_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		$Player/Player_sprite.stop()
		Dialogic.start("winroom_0")
		

func _on_light_animation_finished(anim_name):
	if anim_name == "lightening":
		$transitions/light.visible = false


func _on_transition_animation_finished(anim_name):
	if anim_name == "hi":
		$CanvasLayer/ColorRect.visible = false

func _on_clouds_animation_finished():
	GameState.scene = "window"
	get_tree().change_scene_to_file("res://scenes/world/world_init.tscn")

func _on_dialogic_signal(argument):
	if argument == "done0":
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop() 
		GameState.game_state = "play"
	if argument == "done":
		GameState.game_state = "play"
	if argument == "done2":
		$TileMap.animation = "part2"
		$TileMap.frame = 0
		Dialogic.start("winroom_3")
	if argument == "done3":
		$TileMap.play("part2")
	if argument == "done4":
		$char_opening_win.hide()
		$char_going.show()
		$char_going.play("bye")
	
		
func _on_char_opening_win_animation_finished():
	Dialogic.start("winroom_2")
	


func _on_tile_map_animation_finished():
	if $TileMap.animation == "part2":
		Dialogic.start("winroom_4")

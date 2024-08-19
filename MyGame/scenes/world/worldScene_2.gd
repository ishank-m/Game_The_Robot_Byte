extends Node2D
@onready var transition = $TransitionScene
@onready var player = $Player
@onready var player_anim = $Player/Player_sprite

var to_where: String

func _ready():
	GameState.kingstate = "normal"
	$dead.visible = false
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	if GameState.scene == "worldscene1":
		player.position = $init.position
		player_anim.flip_h = false
		player_anim.play("right")
		player_anim.stop()
	elif GameState.scene == "worldscene3":
		player.position = $village.position
		player_anim.play("down")
		player_anim.stop()
	if GameState.player_pos:
		player.position = GameState.player_pos
		GameState.player_pos = null
	GameState.scene = "worldscene2"

func _physics_process(_delta):
	if not GameState.player_died:
		if GameState.player_health == 0:
			GameState.player_died = true
			$dead.set_position(player.position) 
			var camera = player.get_node("Camera2D")
			player.remove_child(camera)
			get_tree().root.add_child(camera)
			camera.position = player.position
			$Player.queue_free()
			$dead.visible = true

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		to_where = "worldscene3"
		transition.fade_in()
func _on_fade_out_done():
	GameState.game_state = "play"
func _on_fade_in_done():
	if to_where == "worldscene1":
		get_tree().change_scene_to_file("res://scenes/world/worldScene_1.tscn")
	elif to_where == "worldscene3":
		get_tree().change_scene_to_file("res://scenes/world/worldScene_3.tscn")
func _on_clouds_animation_finished():
	$CanvasLayer/clouds.hide()


func _on_to_worldscene_1_body_entered(body):
	if body.name == "Player":
		to_where = "worldscene1"
		transition.fade_in()

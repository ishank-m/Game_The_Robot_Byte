extends Node2D
@onready var transition = $TransitionScene
@onready var player = $Player
var to_where: String
var died = false

func _physics_process(_delta):
	if not died:
		if GameState.player_health == 0:
			var camera = player.get_node("Camera2D")
			player.remove_child(camera)
			get_tree().root.add_child(camera)
			camera.position = player.position
			$Player.queue_free()
			died = true

func _ready():
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	burn()
	if GameState.scene == "worldinit":
		$Player.set_position($init.position)
	elif GameState.scene == "worldscene2":
		$Player.set_position($right.position)
	GameState.scene = "worldscene1"

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		to_where = "world_init"
		transition.fade_in()

func _on_fade_in_done():
	if to_where == "world_init":
		get_tree().change_scene_to_file("res://scenes/world/world_init.tscn")
	elif to_where == "worldscene2":
		get_tree().change_scene_to_file("res://scenes/world/worldScene_2.tscn")
func _on_fade_out_done():
	GameState.game_state = "play"

func _on_to_fight_1_body_entered(body):
	if body.name == "Player":
		to_where = "worldscene2"
		transition.fade_in()

func burn():
	$burning_log.play("default")
	$burning_tree.play("default")
	$burning_tree2.play("default")

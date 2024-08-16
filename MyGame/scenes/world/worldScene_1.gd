extends Node2D
@onready var transition = $TransitionScene
var to_where: String

func _ready():
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	if GameState.scene == "worldinit":
		$Player.set_position($init.position)
		GameState.scene = "worldscene1"
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


func _on_to_fight_1_body_entered(body):
	if body.name == "Player":
		to_where = "worldscene2"
		transition.fade_in()

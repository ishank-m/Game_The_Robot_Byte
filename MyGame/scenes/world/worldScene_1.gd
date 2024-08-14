extends Node2D
@onready var transition = $TransitionScene


func _ready():
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	if GameState.scene_neww == "Scene_1":
		$Player.set_position($init.position)
	elif GameState.scene_neww == "Scene_2":
		$Player.set_position($right.position)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		transition.fade_in()

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/world_init.tscn")


extends Node2D
@onready var transition = $TransitionScene
func _ready():
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	#$CanvasLayer/clouds.hide()
	if GameState.scene_neww == "init" and GameState.scene == "window":
		$Player.set_position($init.position)
		#$CanvasLayer/clouds.play("hi")
	elif GameState.scene_neww == "back":
		$Player/Player.play("down")
		$Player/Player.stop()
		$Player.set_position($up.position)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		transition.fade_in()

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/worldScene_1.tscn")
func _on_clouds_animation_finished():
	$CanvasLayer/clouds.hide()


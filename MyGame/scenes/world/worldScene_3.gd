extends Node2D
@onready var transition = $TransitionScene

func _ready():
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	$Player.set_position($init.position)



func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/worldScene_1.tscn")
func _on_clouds_animation_finished():
	$CanvasLayer/clouds.hide()





func _on_button_pressed():
	transition.fade_in()

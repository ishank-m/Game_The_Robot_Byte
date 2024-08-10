extends Node2D

func _ready():
	$CanvasLayer/ColorRect.visible = true
	$fade_anim.play("hi")
	$Player.set_position($init.position)


func _on_fade_anim_animation_finished(anim_name):
	if anim_name == "hi":
		GameState.game_state = 'play'
	if anim_name == "bye":
		get_tree().change_scene_to_file("res://scenes/world/worldScene_2.tscn")


func _on_area_2d_body_entered(_body):
	$CanvasLayer/ColorRect.visible = true
	$fade_anim.play("bye")



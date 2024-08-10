extends Node2D


func _ready():
	$CanvasLayer/clouds.hide()
	if GameState.scene_neww == "init" and GameState.scene == "window":
		$CanvasLayer/clouds.show()
		$Player.set_position($init.position)
		$CanvasLayer/clouds.play("hi")
	elif GameState.scene_neww == "back":
		$Player/Player.play("down")
		$Player/Player.stop()
		$Player.set_position($up.position)
	$CanvasLayer/ColorRect.visible = true
	$CanvasLayer/ColorRect/AnimationPlayer.play("hi")
	



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$CanvasLayer/ColorRect.visible = true
		$CanvasLayer/ColorRect/AnimationPlayer.play("bye")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hi":
		GameState.game_state = 'play'
		$CanvasLayer/ColorRect.visible = false
	if anim_name == "bye":
		GameState.scene_neww = "Scene_1"
		get_tree().change_scene_to_file("res://scenes/world/worldScene_1.tscn")
		


func _on_clouds_animation_finished():
	$CanvasLayer/clouds.hide()

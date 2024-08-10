extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/ColorRect.visible = true
	$fade_anim.play("hi")
	$Player.set_position($village.position)
	



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$CanvasLayer/ColorRect.visible = true
		$fade_anim.play("bye")


func _on_fade_anim_animation_finished(anim_name):
	if anim_name == "hi":
		GameState.game_state = 'play'
		$CanvasLayer/ColorRect.visible = false
	if anim_name == "bye":
		get_tree().change_scene_to_file("res://scenes/world/worldScene_3.tscn")

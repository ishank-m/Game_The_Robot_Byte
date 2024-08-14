extends Node2D
@onready var transition = $TransitionScene

func _ready():
	transition.connect("finished", _on_transition_finished)
	transition.fade_out()
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
		get_tree().change_scene_to_file("res://scenes/world/worldScene_1.tscn")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hi":
		GameState.game_state = 'play'
		$CanvasLayer/ColorRect.visible = false
	if anim_name == "bye":
		GameState.scene_neww = "Scene_1"
		
		
func _on_transition_finished():
	GameState.game_state = "play"

func _on_clouds_animation_finished():
	$CanvasLayer/clouds.hide()

